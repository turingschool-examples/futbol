module TeamAccuracy

  def find_accuracy_ratios(season_id)
    accuracy_by_team = Hash.new

    @seasons_by_id[season_id][:team_ids].each { |team_id|
    this_teams_goals = 0.0
    this_teams_shots = 0.0
    this_teams_games = @seasons_by_id[season_id][:game_teams].select{|game_team| game_team.team_id == team_id}
    this_teams_goals += this_teams_games.sum{|game| game.goals.to_f}
    this_teams_shots += this_teams_games.sum{|game| game.shots.to_f}
    accuracy_by_team[team_id] = (this_teams_goals / this_teams_shots) 
    }
    accuracy_by_team
  end

end