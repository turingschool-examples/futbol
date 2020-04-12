require 'csv'
require_relative 'collection'

class TeamCollection < Collection
  attr_reader :teams

  def initialize(file_path)
    @teams = create_objects(file_path, Team)
  end

  def count_of_teams
    @teams.length
  end

  def find(team_id_number)
    @teams.find {|team| team.team_id == team_id_number}
  end

  def team_info(team_id_number)
    team_information = {}
    team_object = @teams.find {|team| team.team_id == team_id_number}
    team_information[:team_id] = team_object.team_id
    team_information[:franchiseid] = team_object.franchiseid
    team_information[:teamname] = team_object.teamname
    team_information[:abbreviation] = team_object.abbreviation
    team_information[:link] = team_object.link
    team_information
  end
end
