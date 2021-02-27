require 'CSV'
require 'pry'
require_relative './game_stats'

class GameStatsManager
  def initialize(locations, stat_tracker)
    @all_game_stats = []
    @stat_tracker = stat_tracker
    # binding.pry

    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      @all_game_stats << GameStats.new(row, self)
    end
  end

  # def game
  #
  # end
end
