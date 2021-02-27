require 'CSV'
require 'pry'
require_relative './game_stats'

class GameStatsData
  attr_reader :all_game_stats_data, :stat_tracker

  def initialize(locations, stat_tracker)
    @all_game_stats_data = []
    @stat_tracker = stat_tracker

    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      @all_game_stats_data << GameStats.new(row, self)
    end
  end
end
