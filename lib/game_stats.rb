require 'pry'
require 'csv'

module GameStats

  def self.high_score(contents)
    high_score = contents.max_by do |row|
      row[:home_goals] + row[:away_goals]
    end
    high_score
  end



  LOCATION = {
    game_path: './data/games.csv'
  }
  
  # GAME_DATA = CSV.open LOCATION[:game_path], headers: true, header_converters: :symbol
  GAME_DATA = CSV.open './data/games.csv', headers: true, header_converters: :symbol

end