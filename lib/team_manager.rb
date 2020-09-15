require_relative 'team'
require_relative 'csv_module'


class TeamManager
  include CSVModule
  attr_reader :teams, :stat_tracker, :teams_data
  def initialize(location, stat_tracker)
    @stat_tracker = stat_tracker
    @teams = generate_data(location, Team)
  end

  def find_team(id)
    teams.find { |team| team.team_id == id }
  end

  def game_ids_by_team(id)
    stat_tracker.game_ids_by_team(id)
  end

  def game_team_info(game_id)
    stat_tracker.game_team_info(game_id)
  end

  def game_info(game_id)
    stat_tracker.game_info(game_id)
  end

  def gather_game_team_info(id)
    game_ids_by_team(id).map do |game_id|
      game_team_info(game_id)
    end
  end

  def gather_game_info(id)
    game_ids_by_team(id).map do |game_id|
      game_info(game_id)
    end
  end

  def most_goals_scored(id)
    gather_game_team_info(id).map do |game|
      game[id][:goals]
    end.max
  end

  def fewest_goals_scored(id)
    gather_game_team_info(id).map do |game|
      game[id][:goals]
    end.min
  end

  def total_wins(id, id2 = id)
    gather_game_team_info(id).count do |pair|
      next if pair[id2].nil?

      pair[id2][:result] == 'WIN'
    end
  end

  def opponent_game_count(id, id2)
    gather_game_team_info(id).count do |pair|
      pair[id2]
    end
  end

  def average_win_percentage(id)
    (total_wins(id) / gather_game_team_info(id).count.to_f).round(2)
  end

  def opponent_win_percentage(id, id2)
    (total_wins(id, id2) / opponent_game_count(id, id2).to_f).round(2)
  end

  def opponent_ids(id)
    opponents = gather_game_team_info(id).flat_map(&:keys).uniq
    opponents.delete(id)
    opponents.sort_by(&:to_i)
  end

  def favorite_opponent(id)
    favorite_id = opponent_ids(id).min_by do |opponent_id|
      opponent_win_percentage(id, opponent_id)
    end

    find_team(favorite_id).team_info['team_name']
  end

  def rival(id)
    rival_id = opponent_ids(id).max_by do |opponent_id|
      opponent_win_percentage(id, opponent_id)
    end

    find_team(rival_id).team_info['team_name']
  end

  def game_ids_by_season(id)
    gather_game_info(id).reduce({}) do |collector, game|
      collector[game[:season_id]] = [] if collector[game[:season_id]].nil?
      collector[game[:season_id]] << game[:game_id]
      collector
    end
  end

  def game_teams_by_season(id)
    seasons = game_ids_by_season(id)
    seasons.each do |season, game_ids|
      seasons[season] = game_ids.map do |game_id|
        game_team_info(game_id)
      end
    end

    seasons
  end

  def count_season_wins(id, season)
    season.count do |pair|
      pair[id][:result] == 'WIN'
    end
  end

  def best_season(id)
    seasons = game_teams_by_season(id)
    wins = {}
    seasons.each do |season, games|
      wins[season] = count_season_wins(id, games)
    end

    seasons.keys.max_by do |season|
      (wins[season] / seasons[season].length.to_f).round(2)
    end
  end

  def worst_season(id)
    seasons = game_teams_by_season(id)
    wins = {}
    seasons.each do |season, games|
      wins[season] = count_season_wins(id, games)
    end

    seasons.keys.min_by do |season|
      (wins[season] / seasons[season].length.to_f).round(2)
    end
  end
  #
  # def team_info(team_id)
  #   teams_data[team_id]
  # end

  def team_data_by_id
    @teams.map{|team| [team.team_id, team.team_info]}.to_h
  end

  def count_of_teams
    # @teams_data.count
    teams.count
  end
end
