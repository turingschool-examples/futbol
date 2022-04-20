require './required_files'

module SeasonModule

  def SeasonModule.tackles_hash(season_id, game_teams)
    game_season = []
    game_teams.each do |game|
      if season_id[0..3] == game.game_id[0..3]
        game_season << game
      end
    end
    tackles_hash = {}
    game_season.each do |game|
      if tackles_hash[game.team_id] == nil
        tackles_hash[game.team_id] = game.tackles.to_i
      else
        tackles_hash[game.team_id] += game.tackles.to_i
      end
    end
    tackles_hash
  end

end
