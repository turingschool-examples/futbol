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
      # require "pry";binding.pry
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

  def home_games_by_team
    home_games.group_by do |game_team|
      game_team.team_id
    end
  end

  def highest_scoring_visitor
    # require "pry";binding.pry
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
    team_season_tackles = {}
    game_teams_by_season(season).each do |game|
      if team_season_tackles[game.team_id]
        team_season_tackles[game.team_id] += game.tackles
      else
        team_season_tackles[game.team_id] = game.tackles
      end
    end
    team_season_tackles
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

end
