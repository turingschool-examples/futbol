module Renameable

  def season_verification(game, season)
    game.game_id.start_with?(season[0..3])
  end

  def hash_generator(data_set, key, value, season)
    hash = Hash.new(0)
    data_set.each do |game|
      if season_verification(game, season)
        hash[game.send(key)] += game.send(value).to_i
      end
    end
    hash
  end

  def team_identifier(id)
    matching_team = @teams.find do |team|
      team.team_id == id
    end
    matching_team.team_name
  end
end
