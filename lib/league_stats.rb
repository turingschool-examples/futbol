module LeagueStats

  def best_defense
    best_def = "Nobody"
    least_goals_allowed = 0
    @teams.each do |team|
      goals_allowed = 0
      played_games = @game_teams.find_all { |game_team| game_team.team_id == team.team_id}
      played_games.each do |game|
        if game.home_or_away == "away"
          goals_allowed += @games[game.game_id].home_goals
        end
        if game.home_or_away == "home"
          goals_allowed += @games[game.game_id].away_goals
        end
        if goals_allowed < least_goals_allowed
          best_def = team.team_name
        end
      end
    end
  end

  def worst_defense
    #
  end

  def highest_scoring_visitor
    #
  end
end
