
class GameStatistics
  
  def initialize(locations)
    
  end
  def highest_total_score(contents)
    max = 0
    contents.each do |row|
      total = row[:home_goals].to_i + row[:away_goals].to_i
      max = [max, total].max
    end
    max
  end
end