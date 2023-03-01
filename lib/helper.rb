module Helper

  def total_goals(game)
    game.away_goals + game.home_goals
  end

  def total_games(games)
    games.count
  end
end