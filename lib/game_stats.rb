

def highest_total_score
  all_games.map do |game|
    game.total_score
  end.max
end

def lowest_total_score
  all_games.map do |game|
    game.total_score
  end.min
end