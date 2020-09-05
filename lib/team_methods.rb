require 'CSV'
class TeamMethods
  attr_reader :teams_table, :teams

  def initialize(teams)
    @teams = teams
    @teams_table = create_table(@teams)
  end

  def create_table(file)
    CSV.parse(File.read(file), headers: true)
  end

  def count_of_teams
    @teams_table['teamName'].count
  end

  def find_by_id(team_id)
    team = @teams_table.find do |team|
      team['team_id'] == team_id
    end
    team['teamName']
  end
end
