require './lib/team'



class TeamManager
  attr_reader :team_hash

def initialize(team_path)
  @team_path = team_path
  @team_hash = {} ######## can easily modify to array
  CSV.foreach(team_path, headers: true) do |row|
    team_hash[row[2]] = Team.new(row)
  end
end

end
