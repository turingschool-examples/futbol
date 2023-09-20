require 'csv'
require 'pry'
require 'pry-nav'
require_relative 'game_stats'

class StatTracker
  include GameStats
  def self.from_csv
    data = GAME_DATA.map do |row|
      row
    end
    data
  end

  def self.highest_total_score
    return GameStats.high_score(GAME_DATA)
  end
end

# questions re: modules, other


# Seems like spec_helper

# 