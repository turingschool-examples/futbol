require_relative './game'
require_relative './team'
require_relative './game_teams'
require_relative './game_collection'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)
    @games = info[:games]
    @teams = info[:teams]
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistics Methods
  def highest_total_score
    all_games = GameCollection.new(@games)
    all_games.all.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.max
  end

  def lowest_total_score
    all_games = GameCollection.new(@games)
    all_games.all.map do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end.min
  end
end
