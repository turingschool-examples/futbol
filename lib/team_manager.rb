require_relative 'team'
require 'csv'

class TeamManager
  attr_reader :teams, :stat_tracker
  def initialize(location, stat_tracker)
    @stat_tracker = stat_tracker
    @teams = generate_teams(location)
  end

  def generate_teams(location)
    array = []
    CSV.foreach(location, headers: true) do |row|
      array << Team.new(row.to_hash)
    end
    array
  end

  def team_info(id)
    teams.find do |team|
      team.team_id == id
    end.team_info
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
    opponents.sort_by do |id|
      id.to_i
    end
  end

  def favorite_opponent(id)
    favorite_id = opponent_ids(id).min_by do |opponent_id|
      opponent_win_percentage(id, opponent_id)
    end

    team_info(favorite_id)['team_name']
  end

  def rival(id)
    rival_id = opponent_ids(id).max_by do |opponent_id|
      opponent_win_percentage(id, opponent_id)
    end

    team_info(rival_id)['team_name']
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
end
