class Season
  attr_reader :games
  # each season.unq
  def initialize
    @games = {}
  end

  def add_game(game_id, game, game_team_home, game_team_away)
    @games[game_id] = {game: game,
                       home: game_team_home,
                       away: game_team_away
                      }
  end
end
