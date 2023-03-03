module TeamAccuracy

  def find_accuracy_ratios(season_id)
    team_scores = Hash.new(0)
      team_shots = Hash.new(0)
      team_games = {}
      team_ids = @seasons_by_id[season_id][:team_ids]
      team_ids.each {|team_id| team_games[team_id] = []}
      @seasons_by_id[season_id][:game_teams].each do |game|
        team_games[game.team_id] << game
      end
      team_games.each do |team, games|
        games.each do |game|
          team_scores[team] += game.goals.to_i
          team_shots[team] += game.shots.to_i
        end
      end
      ratios = Hash.new(0.0)
      team_ids.each do |team_id|
        ratios[team_id] = (team_scores[team_id].to_f / team_shots[team_id].to_f)
      end
      return ratios
  end

end