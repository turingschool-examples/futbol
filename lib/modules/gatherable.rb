module Gatherable
  def games_by_team
    @game_collection.collection.inject(Hash.new(0)) do |count, game|
      count[game[1].home_team_id] += 1
      count[game[1].away_team_id] += 1
      count
    end
  end

  def goals_by_team
    @game_collection.collection.inject(Hash.new(0)) do |scores, game|
      scores[game[1].home_team_id] += game[1].home_goals.to_i
      scores[game[1].away_team_id] += game[1].away_goals.to_i
      scores
    end
  end

  def goals_against_team
    @game_collection.collection.inject(Hash.new(0)) do |scores, game|
      scores[game[1].home_team_id] += game[1].away_goals.to_i
      scores[game[1].away_team_id] += game[1].home_goals.to_i
      scores
    end
  end

  def get_team_name_by_id(team_id)
    @team_collection.collection[team_id].team_name
  end

  def collection_helper_home(row, hash, season_hash)
    if !(hash[row[:home_team_id]][row[:season]])
      hash[row[:home_team_id]] = {}
      hash[row[:home_team_id]][row[:season]] = []
    end

    hash[row[:home_team_id]][row[:season]] += season_hash.values.flatten(1)
  end

  def collection_helper_away(row, hash, season_hash)
    if !(hash[row[:away_team_id]][row[:season]])
      hash[row[:away_team_id]] = {}
      hash[row[:away_team_id]][row[:season]] = []
    end

    hash[row[:away_team_id]][row[:season]] += season_hash.values.flatten(1)
  end

  def team_hash(row, team_id)
    { team_id => { row[:season] => [] } }
  end

  def team_season_hash(row, collection_type, season_hash, team_id)
    season_hash[team_id] = { row[:season] => (season_hash[team_id][row[:season]] += [collection_type.new(row)]) }
    season_hash
  end

  def season_data_array(season_hash, team_id)
    season_hash[team_id].values.flatten!
  end

  def team_key(season_hash)
    season_hash.keys[0]
  end

  def season_key(season_hash, key)
    season_hash[key].keys[0]
  end

  def season_parse(key, season_key, season_data, hash)
    if hash.key?(key) && hash[key].key?(season_key)
      hash[key][season_key] << season_data
    elsif hash.key?(key) && !hash[key].key?(season_key)
      { hash[key] => hash[key][season_key] = season_data }
    elsif !hash.has_key?(key) && !hash.empty?
      hash[key] = { season_key => season_data }
    elsif hash.empty?
      hash = { key => { season_key => season_data } }
    end
    hash
  end
end
