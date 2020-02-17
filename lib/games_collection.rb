class GamesCollection

  def initialize(games = {})
    @games = games
  end

  def add_game(game_to_add)
    @games[game_to_add.game_id] = game_to_add
  end


end
