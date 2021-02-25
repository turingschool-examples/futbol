require 'CSV'
require 'pry'
require './lib/game_stats'

class GameStatsData
  def initialize(locations, stat_tracker)
    @all_game_stats_data = []
    @stat_tracker = stat_tracker

    CSV.foreach(@stat_tracker.game_stats_path, headers: true, header_converters: :symbol) do |row|
      @all_game_stats_data << GameStats.new(row)
    end
  end

  # def game
  #
  # end
end
