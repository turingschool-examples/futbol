require 'csv'

class StatTracker
  attr_reader :game_data, :team_data, :game_teams_data
  def initialize
    @game_data = nil
    @team_data = nil
    @game_teams_data = nil
  end
  
  def self.from_csv(locations)
    @game_data = CSV.open locations[:games]
    @team_data = CSV.open locations[:teams]
    @game_teams_data = CSV.open locations[:game_teams] 
    return [@game_data, @team_data, @game_teams_data]
  end

end