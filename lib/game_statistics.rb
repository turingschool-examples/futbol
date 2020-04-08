# require './lib/stat_tracker'
require './lib/statistics'
require 'pry'


class GameStatistics < Statistics
  attr_reader :stat_tracker

  def highest_total_score
    total = @csv_games.map do |row|
      row[:home_goals].to_i + row[:away_goals].to_i
    end
    total.max_by{|score| score}
  end

  def lowest_total_score
    total = @csv_games.map do |row|
      row[:home_goals].to_i + row[:away_goals].to_i
    end
    total.min_by{|score| score}
  end

  def percentage_home_wins

  end 



end
