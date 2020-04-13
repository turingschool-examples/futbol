require 'csv'
require_relative 'team'
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

  def team_info(id)
    number_id = id.to_i
    team_information = {}
    team_object = @teams.find {|team| team.team_id == number_id}
    team_information["team_id"] = team_object.team_id.to_s
    team_information["franchise_id"] = team_object.franchiseid.to_s
    team_information["team_name"] = team_object.teamname
    team_information["abbreviation"] = team_object.abbreviation
    team_information["link"] = team_object.link

    team_information
  end
end
