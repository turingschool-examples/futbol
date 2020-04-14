module Findable

  def find_team_id(id)
    found_team = @team_collection.find do |team|
      team.team_id == id
    end
    named_team = found_team.teamname
    named_team
  end

end
