class GamesCollection

  def initialize()
    @games = {}
  end

  def add(game_to_add)
    @games[game_to_add.game_id] = game_to_add
  end


end
