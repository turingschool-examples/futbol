require_relative './team'
class TeamsManager
  attr_reader :teams, :tracker
  def initialize(teams_path, tracker)
    @teams = []
    @tracker = tracker
    create_games(teams_path)
  end

  def create_games(teams_path)
    teams_data = CSV.parse(File.read(teams_path), headers: true)
    @teams = teams_data.map do |data|
      Team.new(data, self)
    end
  end

  def count_of_teams
    @teams.count
  end

  def find_team_name(team_number)
    @teams.find do |team|
      team.team_id == team_number
    end.team_name
  end
end
