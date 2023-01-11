require_relative '../lib/team'

module TeamCollection
  def find_team(team_id)
	  @teams_array.find {|team| team.team_id == team_id}.team_name
  end
end