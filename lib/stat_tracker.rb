require_relative './games_collection'
require_relative './teams_collection'
require_relative './seasons_collection'
require 'csv'

class StatTracker
  attr_reader :games, :teams, :seasons

  def initialize(locations)
    @games = GamesCollection.new(locations[:games], self)
    @teams = TeamsCollection.new(locations[:teams], self)
    @seasons = SeasonsCollection.new(locations[:game_teams], season_ids, team_ids, self)
  end

  def self.from_csv(locations)
    self.new(locations)
  end

  def find_season_id(game_id)
    @games.find_season_id(game_id)
  end

  def season_ids
    @games.season_ids
  end

  def team_ids
    @teams.team_ids
  end

  def find_by_id(id)
    @teams.find_by_id(id) || @games.find_by_id(id)
  end

  def highest_total_score
    @games.highest_total_score
  end

  def lowest_total_score
    @games.lowest_total_score
  end

  def percentage_home_wins
    @games.percentage_home_wins
  end

  def percentage_visitor_wins
    @games.percentage_visitor_wins
  end

  def percentage_ties
    @games.percentage_ties
  end

  def count_of_games_by_season
    @games.count_of_games_by_season
  end

  def average_goals_per_game
    @games.average_goals_per_game
  end

  def average_goals_by_season
    @games.average_goals_by_season
  end

  def count_of_teams
    @teams.count_of_teams
  end

  def best_offense
    find_by_id(@seasons.best_offense[0])
  end

  def worst_offense
    @game_teams.worst_offense
  end

  def highest_scoring_visitor
    @game_teams.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @game_teams.highest_scoring_hometeam
  end

  def lowest_scoring_visitor
    @game_teams.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @game_teams.lowest_scoring_hometeam
  end

  def team_info(team_id)
    @teams.team_info(team_id)
  end

  def best_season
  end

  def worst_season
  end

  def average_win_percentage
  end

  def most_goals_scored
  end

  def fewest_goals_scored
  end

  def favorite_opponent
  end

  def rival
  end

  def winningest_coach
  end

  def worst_coach
  end

  def most_accurate_team
  end

  def least_accurate_team
  end

  def most_tackles
  end

  def fewest_tackles
  end

end
