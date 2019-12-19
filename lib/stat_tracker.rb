require 'csv'
require_relative 'games_collection'
require_relative 'game_teams_collection'
require_relative 'teams_collection'

class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path

  def self.from_csv(file_paths)
    games_path = file_paths[:games]
    teams_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    @games_path = games_path
    @teams_path = teams_path
    @game_teams_path = game_teams_path
  end

  def game_teams_collection
    GameTeamsCollection.new(@game_teams_path)
  end

  def games_collection
    GamesCollection.new(@games_path)
  end

  def teams_collection
    TeamsCollection.new(@teams_path)
  end
  
  def highest_total_score
    games_collection.highest_total_score
  end

  def lowest_total_score
    games_collection.lowest_total_score
  end

  def biggest_blowout
    games_collection.biggest_blowout
  end

  def percentage_home_wins
    games_collection.percentage_home_wins
  end

  def percentage_visitor_wins
    games_collection.percentage_visitor_wins
  end  
 
   def average_goals_per_game
    games_collection.average_goals_per_game
   end

  def average_goals_by_season
    games_collection.average_goals_by_season
  end
end
