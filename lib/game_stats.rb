require 'pry'

module GameStats
  
  def self.highest_total_score
    contents.max_by do |row|
      row[:home_goals] + row[:away_goals]
    end
  end

end