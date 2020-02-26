require 'csv'
require_relative './team'

class TeamCollection
  attr_reader :teams

  def initialize(team_data)
    @teams = create_teams(team_data)
  end

  def create_teams(team_data)
    team_data.map do |row|
      Team.new(row.to_h)
    end
  end

  def count_of_teams
    teams.length
  end

  def team_info(team_num)
  info = {}
  team_obj = retrieve_team(team_num.to_i)
    info["team_id"] = team_obj.team_id.to_s
    info["franchise_id"] = team_obj.franchiseid.to_s
    info["team_name"] = team_obj.teamname
    info["abbreviation"] = team_obj.abbreviation
    info["link"] = team_obj.link
    info
  end

  def retrieve_team(team_num)
    @teams.find { |team_obj| team_obj.team_id == team_num }
  end
end
