require 'simplecov'
require 'csv'
require 'pry'
require 'pry-nav'
# require_relative 'game_stats'
require './spec/spec_helper'

class StatTracker
  include GameStats
  GAME_DATA = 
  def self.from_csv
    data = GAME_DATA.map do |row|
      binding.pry
      row
    end
    data
  end

  def highest_total_score
    game = GameStats.highest_total_score(GAME_DATA)
    GAME_DATA.close
    game
  end

  def lowest_total_score
    game = GameStats.lowest_total_score(GAME_DATA)
    GAME_DATA.close
    game
  end
end