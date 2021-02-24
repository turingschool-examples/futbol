require 'CSV'
require 'pry'
require './lib/game_stats'

class GameStatsData
  def initialize
    @all_game_teams_data = []
    # @stattracker = stattracker

    CSV.foreach('./data/game_stats.csv', headers: true, header_converters: :symbol) do |row|
      @all_game_stats_data << GameStats.new(row)
    end
    # binding.pry
  end
end
