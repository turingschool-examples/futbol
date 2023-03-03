require_relative './helper'

module TeamStats
  include Helper

  def team_info(input_team_id)
    selected_team = @teams.select {|team| team.team_id == input_team_id}[0]
    team_info = {
      team_id: selected_team.team_id,
      franchise_id: selected_team.franchise_id,
      team_name: selected_team.team_name,
      abbreviation: selected_team.abbreviation,
      link: selected_team.link
    }
  end
end