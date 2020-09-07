require_relative "stat_tracker"

class GameStatistics
  attr_reader :stat_tracker
  def initialize(csv_files,stat_tracker)
    @game_files = csv_files.games
    @stat_tracker = stat_tracker
  end

  def highest_total_score
    highest_total = 0
    @game_files.each do |key, value|
      total = value.away_goals + value.home_goals
      if total > highest_total
        highest_total = total
      end
    end
    @stat_tracker.highest_total_score_stat = highest_total
  end

  def lowest_total_score
    lowest_total = 11
    @game_files.each do |key, value|
      total = value.away_goals + value.home_goals
      if lowest_total > total
        lowest_total = total
      end
    end
    @stat_tracker.lowest_total_score_stat = lowest_total
  end
end
