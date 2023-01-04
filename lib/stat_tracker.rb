require 'CSV'

class StatTracker
  attr_reader :games,
              :teams, 
              :game_teams,
              :game_id
             
  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @game_id = @games[:game_id]
    @season = @games[:season]
    @type = @games[:type].to_s
    @date_time = @games[:date_time]
    @away_team_id = @games[:away_team_id]
    @home_team_id = @games[:home_team_id]
    @away_goals = @games[:away_goals]
    @home_goals = @games[:home_goals]
    @venue = @games[:venue].to_s
    @venue_link = @games[:venue_link].to_s
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