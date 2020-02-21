require 'CSV'
require_relative './game_collection'

class StatTracker

  attr_reader :game_path, :team_path, :game_team_path

  def initialize(game_path, team_path, game_team_path)
    @game_path = game_path
    @team_path = team_path
    @game_team_path = game_team_path
    require 'pry'; binding.pry
  end

  def game_collection
    GameCollection.new(@game_path)
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def count_of_games_by_season(season)
    game_collection.games.length == season
  end

  def average_goals_by_season(season)
    game_count = game_collection.games.length == season
    (game_count.to_f / game_collection.games.length).round(2)
  end
end
