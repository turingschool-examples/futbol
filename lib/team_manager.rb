require './lib/team'

class TeamManager
  attr_reader :teams_array

def initialize(team_path)
  @teams_array = []
    CSV.foreach(team_path, headers: true) do |row|
      @teams_array << Team.new(row)
    end
end



end
