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

  def avg_score(filtered_game_teams = @game_teams)
    ratio(total_score(filtered_game_teams), total_game_teams(filtered_game_teams))
  end

  def total_game_teams(filtered_game_teams = @game_teams)
    filtered_game_teams.count
  end

  def home_or_away_games(hoa)
    @game_teams.select do |game|
      game.hoa == hoa
    end
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

  def games_by_team(team_id)
    @game_teams.select do |game|
      game.team_id == team_id
    end
  end

  def team_goals_by_game(team_id)
    games_by_team(team_id).map do |game|
      game.goals
    end
  end

  def most_goals_scored(team_id)
    team_goals_by_game(team_id).max.to_i
  end

  def fewest_goals_scored(team_id)
    team_goals_by_game(team_id).min.to_i
  end

  def hoa_games_by_team_id(hoa)
    home_or_away_games(hoa).group_by do |game_team|
      game_team.team_id
    end
  end

  def total_score(filtered_game_teams = @game_teams)
    total_score = filtered_game_teams.reduce(0) do |sum, game_team|
      sum += game_team.goals
    end
  end

  def highest_scoring_home_team
    highest_scoring_home_team = hoa_games_by_team_id("home").max_by do |team_id, details|
      avg_score(details)
    end[0]
    @stat_tracker.fetch_team_identifier(highest_scoring_home_team)
  end

  def highest_scoring_visitor
    highest_scoring_visitor = hoa_games_by_team_id("away").max_by do |team_id, details|
      avg_score(details)
    end[0]
    @stat_tracker.fetch_team_identifier(highest_scoring_visitor)
  end

  def lowest_scoring_home_team
    lowest_scoring_home_team = hoa_games_by_team_id("home").min_by do |team_id, details|
      avg_score(details)
    end[0]
    @stat_tracker.fetch_team_identifier(lowest_scoring_home_team)
  end

  def lowest_scoring_visitor
    lowest_scoring_visitor = hoa_games_by_team_id("away").min_by do |team_id, details|
      avg_score(details)
    end[0]
    @stat_tracker.fetch_team_identifier(lowest_scoring_visitor)
  end

  def game_teams_by_opponent(team_id)
    games_by_team(team_id).inject({}) do |result, gameteam|
      if result[@stat_tracker.get_opponent_id(@stat_tracker.get_game(gameteam.game_id), team_id)] == nil
        result[@stat_tracker.get_opponent_id(@stat_tracker.get_game(gameteam.game_id), team_id)] = [gameteam]
      else
        result[@stat_tracker.get_opponent_id(@stat_tracker.get_game(gameteam.game_id), team_id)] << gameteam
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

  def average_win_percentage(team_id)
    ratio(total_wins(filter_by_team_id(team_id)), total_game_teams(filter_by_team_id(team_id)))
  end

  def total_wins(game_teams)
    game_teams.count do |gameteam|
      gameteam.result == "WIN"
    end
  end

  def filter_by_team_id(team_id)
    @game_teams.select do |gameteam|
      team_id == gameteam.team_id
    end
  end

end
