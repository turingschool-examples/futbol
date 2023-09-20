require 'simplecov'
require 'pry'
require 'pry-nav'
require 'csv'

module GameStats

  LOCATION = {
    game_path: './data/games.csv'
  }
  
  def self.get_game_data
    data = CSV.open LOCATION[:game_path], headers: true, header_converters: :symbol
    data
    data.close
  end
  
  def self.highest_total_score(contents)
    high_score = contents.max_by do |row|
      row[:home_goals] + row[:away_goals]
    end
    high_score
  end

  def self.lowest_total_score(contents)
    low_score = contents.min_by do |row|
      row[:home_goals] + row[:away_goals]
    end
    low_score
  end

end
