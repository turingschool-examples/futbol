require 'csv'
require_relative './game'

class StatTracker
  
  def self.from_csv(locations)
    games = []
    CSV.foreach(locations[:games]) do |row|
      game = Hash.new
      game[:game_id] = row[0]
      game[:season] = row[1]
      game[:type] = row[2]
      game[:date_time] = row[3]
      game[:away_team_id] = row[4]
      game[:home_team_id] = row[5]
      game[:away_goals] = row[6]
      game[:home_goals] = row[7]
      game[:venue] = row[8]
      game[:venue_link] = row[9]
      game = Game.new(game)
      games << game
    end
    games.shift
    games
  end
end
