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
end
