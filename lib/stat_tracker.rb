require_relative './game_collection'
require 'CSV'

class StatTracker

  attr_reader :game_path, :team_path, :game_team_path

  def initialize(game_path, team_path, game_team_path)
    @game_path = game_path
    @team_path = team_path
    @game_team_path = game_team_path
  end

  def self.from_csv(locations)
    StatTracker.new(locations[:games], locations[:teams], locations[:game_teams])
  end

  def game_collection
    GameCollection.new(@game_path)
  end

  def highest_total_goals
    highest_score_game = game_collection.games.max_by do |game|
      game.total_goals
    end
    highest_score_game.total_goals
  end

  def percentage_home_wins
    count = game_collection.games.count { |game| game.home_goals > game.away_goals }
    (count.to_f / game_collection.games.length).round(2)
  end

  def percentage_visitor_wins
    count = game_collection.games.count { |game| game.away_goals > game.home_goals }
    (count.to_f / game_collection.games.length).round(2)
  end

  def percentage_ties
    count = game_collection.games.count { |game| game.away_goals == game.home_goals }
    (count.to_f / game_collection.games.length).round(2)
  end
end
