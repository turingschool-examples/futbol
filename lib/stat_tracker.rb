require_relative 'games_collection'
require_relative 'teams_collection'
require_relative 'games_teams_collection'
require 'csv'

class StatTracker
  attr_reader :games, :teams, :games_teams

  def initialize(file_paths)
    @games = GamesCollection.new(file_paths[:games])
    @teams = TeamsCollection.new(file_paths[:teams])
    @games_teams = GamesTeamsCollection.new(file_paths[:game_teams])
  end

  def self.from_csv(file_paths)
    self.new(file_paths)
  end

  def highest_total_score
    @games.highest_total_score
  end

  def lowest_total_score
    @games.lowest_total_score
  end

  def biggest_blowout
    @games_teams.biggest_blowout
  end

  def percentage_home_wins
    @games_teams.percentage_home_wins
  end

  def percentage_visitor_wins
    @games_teams.percentage_visitor_wins
  end

  def percentage_ties
    @games_teams.percentage_ties
  end

  def count_of_games_by_season
    @games.count_of_games_by_season
  end

  def average_goals_per_game
    @games.average_goals_per_game
  end

  def average_goals_by_season
    @games.average_goals_per_season
  end

  # Helper method
  def name_of_team(team_id)
    @teams.name_of_team_by_id(team_id)
  end

  def winningest_team
    name_of_team(@games_teams.team_id_with_best_win_percentage)
  end

  def best_fans
    name_of_team(@games_teams.team_with_best_home_win_percentage)
  end

  def worst_fans
    @games_teams.teams_with_better_away_win_percentage_than_home.map { |team_id| name_of_team(team_id) }
  end
end
