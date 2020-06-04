require_relative 'loadable'
require_relative 'team'

class TeamCollection
  include Loadable
  attr_reader :teams_array

  def initialize(file_path)
    @teams_array = create_teams_array(file_path)
  end

  def create_teams_array(file_path)
    load_from_csv(file_path, Team)
  end

  def total_number_of_teams
    @teams_array.length

  end

  def team_name_by_id(team_id)
    @teams_array.find do |team|
      team.team_id.to_i == team_id
    end.team_name
  end

  def team_info(team_id)
    team_information = {}
    @teams_array.find_all do |team|
      if team.team_id == team_id.to_s
        team_information = team.instance_variables.each_with_object({}) { |var, hash| hash[var.to_s.delete("@")] = team.instance_variable_get(var) }
        team_information.delete("stadium")
      end
    end
    team_information
  end
end
