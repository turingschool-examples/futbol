require_relative '../spec/spec_helper'
require '../lib/game'

class StatTracker 

    attr_reader :data, :games

  def initialize(data)
    @data = data
    @games = create_games(@data[:games])
  end

  def self.from_csv(locations)
    new_locations = {}
    locations.each do |key,value|
      new_locations[key] = CSV.open value, headers: true, header_converters: :symbol
    end
    new(new_locations)
  end

  def create_games(game_data)
    all_games = []
    game_data.each do |row|
      all_games << Game.new(row)
    end
    all_games
  end

end