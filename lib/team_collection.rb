require_relative '../lib/team'

module TeamCollection
  def find_team(team_collection, team_id)
	  team_collection.find {|team| team.team_id == team_id}.team_name
  end
end