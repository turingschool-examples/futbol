module TeamUtility

  def team_name(id)
    @teams.each do |team|
        return team.team_name if team.team_id == id 
    end
  end

  def hoa_all_game_teams
    @hoa_all_game_teams ||= @game_teams.group_by { |game_team| game_team.hoa }
  end

  def all_gameteams_by_game_id
    @all_gameteams_by_game_id ||= @game_teams.group_by { |game_team| game_team.game_id }
  end

end