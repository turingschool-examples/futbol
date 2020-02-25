require_relative 'calculable'
require_relative 'hashable'

module TeamStatistics
  include Calculable
  include Hashable

  def team_info(team_id)
    @teams.reduce({}) do |team_info, team|
      team_info["team_id"] = team.team_id if team.team_id == team_id
      team_info["franchise_id"] = team.franchise_id if team.team_id == team_id
      team_info["team_name"] = team.team_name if team.team_id == team_id
      team_info["abbreviation"] = team.abbreviation if team.team_id == team_id
      team_info["link"] = team.link if team.team_id == team_id
      team_info
    end
  end
end
