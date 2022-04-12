module TeamStatistics
  def team_info(team_id)
    teams = TeamStats.create_a_list_of_teams(@teams)
    the_team = teams.find { |team| team.team_id == team_id }
    { 'team_id' => the_team.team_id,
      'franchise_id' => the_team.franchise_id,
      'team_name' => the_team.team_name,
      'abbreviation' => the_team.abbreviation,
      'link' => the_team.link }
  end
end
