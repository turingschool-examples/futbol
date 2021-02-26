require 'CSV'
require 'pry'
require_relative './game_stats'

class GameStatsData
  def initialize(locations, stat_tracker)
    @all_game_stats_data = []
    @stat_tracker = stat_tracker
    # binding.pry

    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      @all_game_stats_data << GameStats.new(row)
    end
  end

  # def game
  #
  # end
end
