require 'pry'
require 'csv'

class StatTracker

  attr_reader :game_statistics, :stat_tracker
  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def self.from_csv(locations)
    info = []
    locations.each do |key, path|
      data = CSV.open path, headers: true, header_converters: :symbol
      info << data
    end
    return info
  end

  def highest_total_score
    total = 0
    @game_statistics.each do |row|
      if total < row[:home_goals].to_i + row[:away_goals].to_i
        total = row[:home_goals].to_i + row[:away_goals].to_i
      end
    end
    return total
  end

end
