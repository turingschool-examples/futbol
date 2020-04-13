require 'csv'
require_relative 'team'

class TeamCollection < Collection
  attr_reader :teams

  def initialize(file_path)
    @teams = create_objects(file_path, Team)
  end

  def count_of_teams
    @teams.length
  end

  def team_info(id)
    number_id = id.to_i
    team_information = {}
    team_object = @teams.find {|team| team.team_id == number_id}
    team_information[:team_id] = team_object.team_id
    team_information[:franchiseid] = team_object.franchiseid
    team_information[:teamname] = team_object.teamname
    team_information[:abbreviation] = team_object.abbreviation
    team_information[:link] = team_object.link
    team_information
  end
end
