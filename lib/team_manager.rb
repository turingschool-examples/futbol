require 'csv'
require_relative './team'

class TeamManager
  attr_reader :teams_data, :teams

  def initialize(file_location)
    @teams_data = file_location
    @teams = []
  end

  def all
    CSV.foreach(@teams_data, headers: true) do |row|
      teams_attributes = {
        "team_id" => row["team_id"],
        "franchise_id" => row["franchise_id"],
        "team_name" => row["team_name"],
        "abbreviation" => row["abbreviation"],
        "link" => row["link"]
      }
      @teams << Team.new(teams_attributes)
    end
  end

  def team_info(id)
    id_team = @teams.find do |team|
      team.team_id == id.to_s
    end
    id_team.team_data
  end

  def count_of_teams
    @teams.size
  end
end
