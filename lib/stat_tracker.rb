require 'pry'
require 'csv'

class StatTracker

  def initialize(stats)
    @stats = stats
  end

  def self.from_csv(locations)
    info = []
    locations.each do |key, path|
      info << CSV.read(path, headers: true, header_converters: :symbol)
    end
    StatTracker.new(info)
  end

  def highest_total_score
    total = 0
    @stats[0].each do |row|
      if total < row[:home_goals].to_i + row[:away_goals].to_i
        total = row[:home_goals].to_i + row[:away_goals].to_i
      end
    end
    return total
  end

end
