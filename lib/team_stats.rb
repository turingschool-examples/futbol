require './lib/stats'
require_relative 'hashable'
require_relative 'groupable'

class TeamStats < Stats
  include Hashable
  include Groupable
  attr_reader :tracker

  def initialize(tracker)
    super(game_stats_data, game_teams_stats_data, teams_stats_data)
  end

  def count_of_teams
    @teams_stats_data.length
  end

  def group_by_team_id
    @tracker.league_stats.group_by_team_id
  end

  def most_accurate_team(season)
    accurate = @teams_stats_data.find do |team|
      team.teamname if @tracker.season_stats.find_most_accurate_team(season) == team.team_id
    end
    accurate.teamname
  end

  def least_accurate_team(season)
    not_accurate = @teams_stats_data.find do |team|
      team.teamname if @tracker.season_stats.find_least_accurate_team(season) == team.team_id
    end
    not_accurate.teamname
  end

  def most_tackles(season)
    most_tackles = @teams_stats_data.find do |team|
      team.teamname if @tracker.season_stats.find_team_with_most_tackles(season) == team.team_id
    end
    most_tackles.teamname
  end

  def fewest_tackles(season)
    fewest_tackles = @teams_stats_data.find do |team|
      team.teamname if @tracker.season_stats.find_team_with_fewest_tackles(season) == team.team_id
    end
    fewest_tackles.teamname
  end

  def team_info(team_id)
    hash = {}
    @teams_stats_data.each do |team|
      if team_id == team.team_id.to_s
        hash['team_id'] = team.team_id.to_s
        hash['franchise_id'] =  team.franchiseid.to_s
        hash['team_name'] = team.teamname
        hash['abbreviation'] = team.abbreviation
        hash['link'] = team.link
      end
    end
    hash
  end

  def all_team_games(team_id)
    @tracker.league_stats.all_team_games(team_id)
  end

  def best_season(team_id)
    best = percent_wins_by_season(team_id).max_by do |season, percent_wins|
      percent_wins
    end
    best_year = best[0].to_i
    result = "#{best_year}201#{best_year.digits[0] + 1}"
  end

  def worst_season(team_id)
    worst = percent_wins_by_season(team_id).min_by do |season, percent_wins|
      percent_wins
    end
    worst_year = worst[0].to_i
    result = "#{worst_year}201#{worst_year.digits[0] + 1}"
  end

  def average_win_percentage(team_id)
  (total_wins(team_id).count.to_f / all_team_games(team_id).count).round(2)
  end

  def total_wins(team_id)
    all_team_games(team_id).find_all do |game|
      game.result == "WIN"
    end
  end

  def most_goals_scored(team_id)
    most = all_team_games(team_id).max_by do |game|
      game.goals
    end
    most.goals
  end

  def fewest_goals_scored(team_id)
    fewest = all_team_games(team_id).min_by do |game|
      game.goals
    end
    fewest.goals
  end

  def find_all_game_ids_by_team(team_id)
    @tracker.game_stats.find_all_game_ids_by_team(team_id)
  end

  def find_opponent_id(team_id)
    find_all_game_ids_by_team(team_id).map do |game|
      if game.home_team_id == team_id
        game.away_team_id
      else
        game.home_team_id
      end
    end
  end

  def favorite_opponent_id(team_id)
    fav_opponent = find_percent_of_winning_games_against_rival(team_id).max_by do |rival_id, wins|
      wins
    end
    fav_opponent[0]
  end

  def favorite_opponent(team_id)
    opponent_id = favorite_opponent_id(team_id)
    opponent_name = @teams_stats_data.find do |team|
      team.teamname if opponent_id == team.team_id.to_s
    end
    opponent_name.teamname
  end

  def rival_opponent_id(team_id)
    rival_opponent = find_percent_of_winning_games_against_rival(team_id).min_by do |rival_id, wins|
      wins
    end
    rival_opponent[0]
  end

  def rival(team_id)
    opponent_id = rival_opponent_id(team_id)
    opponent_name = @teams_stats_data.find do |team|
      team.teamname if opponent_id == team.team_id.to_s
    end
    opponent_name.teamname
  end
end
