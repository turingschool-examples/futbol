module TackleCounter

  def count_tackles(season_id)
    tackles = Hash.new(0)
    @seasons_by_id[season_id][:game_teams].each do |game_team|
      tackles[game_team.team_id] += game_team.tackles.to_i
    end
    tackles
  end
end