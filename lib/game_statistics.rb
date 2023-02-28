
class GameStatistics
  
  def initialize()
    # require 'pry'; binding.pry
    # @home_goals = game_stats[:home_goals]
    # @away_goals = game_stats[:away_goals]
    
    
  end
  def highest_total_score(contents)
    array = []
    array2 = []
    contents.each do |row|
      @home_goals = row[:home_goals].to_i
      @away_goals = row[:away_goals].to_i
      array << @home_goals
      array << @away_goals
      # require 'pry'; binding.pry
    end
    puts  "#{@home_goals} and #{@away_goals}" 
    # array.max(@home_goals) + array.max(@away_goals)
  end
  
end