require 'csv'

class Team

attr_reader :id,
            :team_name
            
  def initialize(team_data)
    @id = team_data[:team_id]
    @team_name = team_data[:teamname]
  end 
end