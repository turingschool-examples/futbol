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

  def greater_than(data_set, header_1, header_2)
    data_set.count do |game|
      game.send(header_1) > game.send(header_2)
    end
  end

  def equal_to(data_set, header_1, header_2)
    data_set.count do |game|
      game.send(header_1) == game.send(header_2)
    end
  end
end
