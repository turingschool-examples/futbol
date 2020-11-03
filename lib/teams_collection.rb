require_relative './team'

class TeamsCollection
  attr_reader :teams
  def initialize(file_path)
    @teams = create_teams(file_path)
  end

  def create_teams(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol).map do |row|
      Team.new(row)
    end
  end

  def find_team_name(team_id)
    teams.find do |team|
      return team.teamname if team.team_id == team_id
    end
  end

  def count_of_teams
    @teams.length
  end

  def team_info(team_id)
    the_team = @teams.find do |team|
      team.team_id == team_id
    end
    the_team.team_info
  end
end
