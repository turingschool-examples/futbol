require './lib/game_factory'

class GameStats
  
  def initialize
    game_factory = GameFactory.new
    game_factory.create_games('./data/games.csv') 
    @games = game_factory.games
  end

  def percent_of_ties
    ties = @games.count do |game|
      game[:away_goals] == game[:home_goals]

    end
    (ties.to_f / @games.length).round(2)
  end
end
