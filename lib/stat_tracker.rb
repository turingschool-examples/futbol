require "csv"
require "./lib/game"

class StatTracker
  @@games =[]
  def self.from_csv(location)
    games_data = CSV.read(location[:games], headers: true)
    @@games = games_data.map do |row|
       Game.new(row)
     end
    StatTracker.new
  end

  def games
    @@games
  end
end
