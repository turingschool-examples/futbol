require 'csv'
require_relative 'game'

class StatTracker

attr_reader :games, :team, :game_teams

  def initialize(locations)
    @games = read_and_create_games(locations[:games])
    # @teams =
    # @game_teams =
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def read_and_create_games(games_csv)
    games_array = []
    CSV.foreach(games_csv, headers: true, header_converters: :symbol) do |row|
      games_array << Game.new(row)
    end
    games_array
  end

end
