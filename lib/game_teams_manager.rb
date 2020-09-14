require 'csv'
require_relative './stat_tracker'
require_relative './game_team'
require_relative './manageable'

class GameTeamsManager
  include Manageable
  attr_reader :stat_tracker, :game_teams

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @game_teams = []
    create_game_teams(path)
  end

  def create_game_teams(game_teams_table)
    @game_teams = game_teams_table.map do |row|
      GameTeam.new(row)
    end
  end

  def total_score(filtered_game_teams = @game_teams)
    filtered_game_teams.count do |game_team|
      game_team.goals
    end
  end

  def avg_score(filtered_game_teams = @game_teams)
    ratio(total_score(filtered_game_teams), total_game_teams(filtered_game_teams))
  end

  def total_game_teams(filtered_game_teams = @game_teams)
    filtered_game_teams.count
  end

  def away_games_by_team
    away_games.group_by do |game_team|
      game_team.goals
    end
  end

  # USE THIS OR INDIVIDUAL ONES?
  def home_or_away_games(where = "home")
    @game_teams.select do |game|
      game.hoa == where
    end
  end

  def away_games
    @game_teams.select do |game_team|
      game_team.hoa == "away"
    end
  end

  # Does this have a method?
  # def home_games_by_team
  #   home_games.group_by do |game_team|
  #     game_team.team_id
  #   end
  # end

  def highest_scoring_visitor
    high = away_games_by_team.max_by do |team_id, details|
      avg_score(details)
    end[0]
    @stat_tracker.team_id_to_team_name(high)
  end

  def all_teams_win_percentage(season)
    percent_wins = {}
    @stat_tracker.fetch_all_team_ids.each do |team_id|
      percent_wins[team_id] = @stat_tracker.fetch_season_win_percentage(team_id, season)
    end
    percent_wins
  end

  def winningest_team(season)
    all_teams_win_percentage(season).max_by do |team_id, win_percentage|
      win_percentage
    end.first
  end

  def worst_team(season)
    all_teams_win_percentage(season).min_by do |team_id, win_percentage|
      win_percentage
    end.first
  end

  def coaches_by_season(team_id, season)
    require "pry"; binding.pry
    #fetch_game_ids_by_season (returns array with all game_ids for season)
  end

  def winningest_coach(season)
    @game_teams.find do |game_team|
      game_team.team_id == winningest_team(season)
    end.head_coach
  end

  def worst_coach(season)
    @game_teams.find do |game_team|
      game_team.team_id == worst_team(season)
    end.head_coach
  end

  def game_teams_by_season(season)
    game_ids = @stat_tracker.fetch_game_ids_by_season(season)
    @game_teams.find_all do |game|
      game_ids.include?(game.game_id)
    end
  end

  def team_tackles(season)
    game_teams_by_season(season).reduce(Hash.new(0)) do |team_season_tackles, game|
      team_season_tackles[game.team_id] += game.tackles
      team_season_tackles
    end
  end

  def most_tackles(season)
    @stat_tracker.fetch_team_identifier(team_tackles(season).max_by do |team|
      team.last
    end.first)
  end

  def fewest_tackles(season)
    @stat_tracker.fetch_team_identifier(team_tackles(season).min_by do |team|
      team.last
    end.first)
  end

  def filter_by_teamid(id)
    @game_teams.select do |game_team|
      game_team.team_id == id
    end
  end

  def game_teams_by_opponent(teamid)
    filter_by_teamid(teamid).inject({}) do |result, gameteam|
      if result[@stat_tracker.get_opponent_id(@stat_tracker.get_game(gameteam.game_id), teamid)] == nil
        result[@stat_tracker.get_opponent_id(@stat_tracker.get_game(gameteam.game_id), teamid)] = [gameteam]
      else
        result[@stat_tracker.get_opponent_id(@stat_tracker.get_game(gameteam.game_id), teamid)] << gameteam
      end
      result
    end
  end

  def game_ids_per_season(season)
    @stat_tracker.seasonal_game_data[season].map do |games|
      games.game_id
    end
  end

  def find_game_teams(game_ids)
    game_ids.flat_map do |game_id|
      @game_teams.find_all do |game|
        game_id == game.game_id
      end
    end
  end

  def shots_per_team_id(season)
    game_search = find_game_teams(game_ids_per_season(season))
    game_search.reduce(Hash.new(0)) do |results, game|
      results[game.team_id] += game.shots
      results
    end
  end

  def season_goals(season)
    specific_season = @stat_tracker.seasonal_game_data[season]
    specific_season.reduce(Hash.new(0)) do |season_goals, game|
      season_goals[game.away_team_id.to_s] += game.away_goals
      season_goals[game.home_team_id.to_s] += game.home_goals
      season_goals
    end
  end

  def shots_per_goal_per_season(season)
    season_goals(season).merge(shots_per_team_id(season)) do |team_id, goals, shots|
      ratio(shots, goals, 3)
    end
  end

  def most_accurate_team(season)
    most_accurate = shots_per_goal_per_season(season).min_by { |team, avg| avg}
    @stat_tracker.fetch_team_identifier(most_accurate[0])
  end

  def least_accurate_team(season)
    least_accurate = shots_per_goal_per_season(season).max_by { |team, avg| avg}
    @stat_tracker.fetch_team_identifier(least_accurate[0])
  end

end
