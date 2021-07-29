class Season
  attr_reader :season
  # each season.unq
  def initialize
    @games = {}
  end

  def add_game(game_id, game, game_teams)
      @games[game_id] = {game: game,
                         home: game_teams[:hoa]
                        }
  end
end
