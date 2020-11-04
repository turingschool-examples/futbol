require 'csv'

class TeamManager
  attr_reader :teams

  def initialize(file_location)
    all(file_location)
  end

  def all(file_location)
    teams_data = CSV.read(file_location, headers: true)
    @teams = teams_data.map do |team_data|
      Team.new(team_data)
    end
  end

  def team_name(id)
    @teams.find do |team|
      team.team_id == id
    end.team_name
  end

  def team_info(id)
    @teams.find do |team|
      team.team_id == id
    end.team_info
  end

  def count_of_teams
    @teams.size
  end
end
