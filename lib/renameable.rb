module Renameable

  def season_verification(game, season)
    game.game_id.start_with?(season[0..3])
  end
end
