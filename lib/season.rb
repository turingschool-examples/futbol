class Season
  attr_reader :games

  def initialize
    @games = {}# rename to game data per game_id
  end

  def add_game(game_id, game, game_team_home, game_team_away)
    @games[game_id] = {game: game,
                       home: game_team_home,
                       away: game_team_away
                      }
  end
end
