require 'csv'
require './runner'


class StatTracker

  def initialize
   
  end

  def self.from_csv(locations)
    game_data = CSV.open locations.games, headers: true, header_converters: :symbol
    game_data.map do |row|
      row
    end
    StatTracker.new
  end
  
end

