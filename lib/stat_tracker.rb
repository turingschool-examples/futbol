
# require './spec_helper'


# class StatTracker

#   def initialize
  
#   end

#   def self.from_csv(locations)
#     contents = CSV.open locations[:games], headers: true, header_converters: :symbol
#     contents.each do |row|
#       row
#       require 'pry'; binding.pry
#     end
#     # StatTracker.new
#   end

# end
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
