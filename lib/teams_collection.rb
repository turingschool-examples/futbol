require 'csv'
require_relative 'team'
require_relative 'csvloadable'

class TeamsCollection
  include CsvLoadable

  attr_reader :teams

  def initialize(teams_path)
    @teams = create_teams(teams_path)
  end

  def create_teams(teams_path)
    create_instances(teams_path, Team)
  end

  def count_of_teams
    @teams.length
  end

  def associate_team_id_with_team_name(id)
    tname = @teams.find { |team| team.team_id == id }
    tname.teamname
  end

  def team_info(teamid)
    matchingteam = teams.find {|team| team.team_id == teamid}
    infohash = {"team_id" => matchingteam.team_id.to_s, "franchise_id" => matchingteam.franchiseid, "team_name" => matchingteam.teamname, "abbreviation" => matchingteam.abbreviation, "link" => matchingteam.link}
  end
  
  def associate_multi_team_id_with_team_name(id)
    id.map do |x|
      tname = @teams.find { |team| team.team_id == x }
      tname.teamname
    end
  end
end
