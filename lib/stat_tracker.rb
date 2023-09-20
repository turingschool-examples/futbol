require 'pry'
require 'pry-nav'
require_relative 'game_stats'

class StatTracker
  include GameStats

  def self.from_csv(locations)
    binding.pry
    contents = CSV.open locations[:games], headers: true, header_converters: :symbol
    game_data = contents.map do |row|
      row
    end
    game_datA
  end

end