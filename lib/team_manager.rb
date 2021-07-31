require_relative './team'

class TeamManager
  attr_reader :teams

  def initialize(locations)
    @teams = Team.read_file(locations[:teams])
  end
  #
  def team_by_id(id)
    team_return = @teams.find do |team|
       team.team_id == id
     end
     team_return
  end

  def team_info(id)
    info = {
      team_id: team_by_id(id).team_id,
      franchise_id: team_by_id(id).franchise_id,
      team_name: team_by_id(id).team_name,
      abbreviation: team_by_id(id).abbreviation,
      link: team_by_id(id).link
    }
  end

  

  # def team_info(team_id)
  #   find_team = @teams.find do |team|
  #     team.team_id == team_id
  #   end
  #   team_info = {
  #     team_id: find_team.team_id,
  #     franchise_id:  find_team.franchise_id,
  #     team_name:  find_team.team_name,
  #     abbreviation: find_team.abbreviation,
  #     link:  find_team.link
  #   }
  # end
end
