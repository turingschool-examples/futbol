require 'csv'
require './lib/stat_tracker'
require './lib/game'

class GamesManager

  def initialize(path, stat_tracker)
    @stat_tracker = stat_tracker
    @games = []
    create_games(path)
  end

  def create_games(games_table)
    @games = games_table.map do |data|
      Game.new(data, self)
    end
  end


  # def self.from_csv(path = "./data/games_sample.csv")
  #   games = []
    # CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
    #   games << self.new(row)
  #   end
  #   @@all_games = games
  # end

end
