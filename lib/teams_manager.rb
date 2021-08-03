require_relative 'team'
require_relative 'parsable'

class TeamsManager
  include Parsable
  attr_reader :teams

  def initialize(file_path)
    @teams = make_objects(file_path, Team)
  end

  def team_info(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  def count_of_teams
    @teams.count
  end

  def team_by_id(team_id)
    team_info(team_id).team_name
  end
end
