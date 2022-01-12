module DataCollector
  def find_name_by_ID(name_id)
    @teams.select do |team|
      team.team_id == name_id
    end
  end

  def home_away_or_tie(game, home_away_tie)
    if home_away_tie == "home"
      game.home_goals > game.away_goals
    elsif home_away_tie == "away"
      game.home_goals < game.away_goals
    else
      game.home_goals == game.away_goals
    end
  end

  def games_by_season_hash
    @games.group_by do |game|
      game.season
    end
  end

  def get_team(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end
  end

  def find_games(results)
    game_results = []
    @games.each do |game|
      results.each do |game_team|
        game_results << game if game.game_id == game_team.game_id
      end
    end
    game_results
  end
end
