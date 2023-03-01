require_relative '../spec/spec_helper'

class StatTracker 

    attr_reader :data

  def initialize(data)
    @data = data
    @games = create_games(@data)
  end

  def self.from_csv(locations)
    new_locations = {}
    locations.each do |key,value|
      new_locations[key] = CSV.open value, headers: true, header_converters: :symbol
    end
    new(new_locations)
  end

  def create_games(game_data)

end