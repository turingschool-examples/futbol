require_relative 'team'
require_relative 'parsable'

class TeamsManager
  include Parsable
  attr_reader :teams

  def initialize(file_path)
    @teams = make_objects(file_path, Team)
  end

  def team_info(team_id)
    team = @teams.find do |team|
      team.team_id == team_id
    end
    format_team_info(team)
  end

  def format_team_info(team)
    {
      'team_id' => team.team_id,
      'franchise_id' => team.franchise_id,
      'team_name' => team.team_name,
      'abbreviation' => team.abbreviation,
      'link' => team.link
    }
  end

  def count_of_teams
    @teams.count
  end

  def team_by_id(team_id)
    team = @teams.find do |team|
      team.team_id == team_id
    end
    team.team_name
  end
end
