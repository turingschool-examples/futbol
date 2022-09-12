require 'csv'

class StatTracker
  def initialize 
    @game_data = nil
    @team_data = nil
    @game_team_data = nil
  end
  
  def self.from_csv(locations)
    @game_data = CSV.open locations[:games]
    @team_data = CSV.open locations[:teams]
    @game_team_data = CSV.open locations[:game_teams] 
  end

  def self.hamburger()
    @game_team_data.each do |row|
      puts row
    end
  end
end