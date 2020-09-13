require 'CSV'

class TeamMethods
  attr_reader :teams_array, :teams

  def initialize(teams)
    @teams = teams
    @teams_array = create_table(@teams)
  end

  def create_table(file)
    CSV.parse(File.read(file), headers: true)
  end

  def count_of_teams
    @teams_array['teamName'].count
  end

  def find_by_id(team_id)
    team = @teams_array.find do |team|
      team['team_id'] == team_id
    end
    team['teamName']
  end
end
