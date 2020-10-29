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

  def team_info(id)
    id_team = @teams.find do |team|
      team.team_id == id.to_s
    end
    {
      "team_id" => id_team.team_id,
      "franchise_id" => id_team.franchise_id,
      "team_name" => id_team.team_name,
      "abbreviation" => id_team.abbreviation,
      "link" => id_team.link
    }
  end

  def team_name(id)
    team_info(id)["team_name"]
  end

  def count_of_teams
    @teams.size
  end
end
