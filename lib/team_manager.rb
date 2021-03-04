require 'CSV'
require 'pry'
require_relative './team'
require_relative './csv_parser'

class TeamManager
  include CsvParser

  def initialize(file)
    @all_teams = load_it_up(file, Team)
  end

  def count_of_teams
    @all_teams.count
  end

  def find_team_by_id(team_id)
    @all_teams.find do |team|
      team.team_id == team_id
    end
  end

  def team_info(id)
    team = @all_teams.find do |team|
      team.team_id == id
    end
      info = {
        "team_id" => team.team_id.to_s,
        "franchiseid" => team.franchiseid.to_s,
        "teamname" => team.teamname,
        "abbreviation" => team.abbreviation,
        "link" => team.link
                }
    end
  end
end
