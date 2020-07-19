class GameStats < Stats

def unique_games
  @games.count
end

def highest_total_score
  @games.map do |game|
    game.away_goals + game.home_goals
  end.max
end

end
