require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'game_team_repo'

class TeamRepo
  attr_reader :teams

  def initialize(locations)
    @teams = Team.read_file(locations[:teams])
  end

  def count_of_teams
    @teams.count
  end

  def get_team_name(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end.team_name
  end
  
  def team_info(team_id)
    team_info = @teams.find { |team| team.team_id == team_id }
    {
      'team_id' => team_info.team_id,
      'franchise_id' => team_info.franchise_id,
      'team_name' => team_info.team_name,
      'abbreviation' => team_info.abbreviation,
      'link' => team_info.link
    }
  end
end