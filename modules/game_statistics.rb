require './lib/game'

module GameStats
  def highest_total_score
    games = Game.create_list_of_games(@games)
    games.map { |game| game.away_goals + game.home_goals }.sort[-1]
  end
end
