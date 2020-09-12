module Findable
  def find_team_by_team_id(id)
    team_manager.teams.find do |team|
      team.team_id == id
    end.team_name
  end
end
