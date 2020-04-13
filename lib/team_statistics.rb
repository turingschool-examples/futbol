module TeamStatistics

  def team_info(team_id)
     found_team = @teams.find do |team|
       team.team_id == team_id
     end
     {
       :team_id => found_team.team_id,
       :franchise_id => found_team.franchise_id,
       :team_name => found_team.team_name,
       :abbreviation => found_team.abbreviation,
       :link => found_team.link
     }
  end
end
