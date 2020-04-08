# require './lib/stat_tracker'
require 'pry'


class GameStatistics
  attr_reader :stat_tracker
  def initialize(stats)
    @stat_tracker = stats
    @csv = CSV.read(stat_tracker.games, headers: true, header_converters: :symbol)
  end

  def highest_total_score
    total = @csv.map do |row|
      row[:home_goals].to_i + row[:away_goals].to_i
    end
    total.max_by{|score| score}
  end



end
