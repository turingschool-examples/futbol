require 'CSV'

class StatTracker
  attr_reader  :games, :teams, :game_teams 
             
  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
# end     




















































































  def count_of_teams
    @teams.count
  end

  # def season_goals(away, home)
  #   season_goals =[]
  #   i = 0
  #   while i <= count_of_teams
  #     old_goals = away[i] + home[i]
  #     season_goals << old_goals

  #     i += 1
  #   end
  #   season_goals
  # end
    

  # def best_offense
    
  # end
end