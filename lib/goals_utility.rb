module GoalsUtility

  def sums_of_home_away_goals
    @sums_of_home_away_goals ||= @games.map { |game| (game.away_goals + game.home_goals)}
  end
  
  def team_id_all_goals
    team_id_all_goals_hash = Hash.new { |hash, key| hash[key] = [] }
    @game_teams.each do |game_teams|
      team_id_all_goals_hash[game_teams.team_id] << game_teams.goals.to_f
    end
    @team_id_all_goals ||= team_id_all_goals_hash
  end

  def hoa_all_game_teams
    @hoa_all_game_teams ||= @game_teams.group_by { |game_team| game_team.hoa }
  end

end