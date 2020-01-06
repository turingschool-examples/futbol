module Gatherable
  def games_by_team
    @games.collection.inject(Hash.new(0)) do |count, game|
      count[game[1].home_team_id] += 1
      count[game[1].away_team_id] += 1
      count
    end
  end

  def home_games_by_team
    @games.collection.inject(Hash.new(0)) do |count, game|
      count[game[1].home_team_id] += 1
      count
    end
  end

  def away_games_by_team
    @games.collection.inject(Hash.new(0)) do |count, game|
      count[game[1].away_team_id] += 1
      count
    end
  end

  def wins_by_team(collection)
    collection.inject(Hash.new(0)) do |wins, game|
      if game[1].home_goals.to_i > game[1].away_goals.to_i
        wins[game[1].home_team_id] += 1
      elsif game[1].away_goals.to_i > game[1].home_goals.to_i
        wins[game[1].away_team_id] += 1
      end
      wins
    end
  end

  def postseason_games_by_team
    @games.collection.inject(Hash.new(0)) do |count, game|
      if game[1].type == 'Postseason'
        count[game[1].home_team_id] += 1
        count[game[1].away_team_id] += 1
      end
      count
    end
  end

  def regular_season_games_by_team
    @games.collection.inject(Hash.new(0)) do |count, game|
      if game[1].type == 'Regular Season'
        count[game[1].home_team_id] += 1
        count[game[1].away_team_id] += 1
      end
      count
    end
  end

  def games_by_season(season_id)
    @games.collection.inject(Hash.new(0)) do |count, game|
      if game[1].season == season_id
        count[game[1].home_team_id] += 1
        count[game[1].away_team_id] += 1
      end
      count
    end
  end

  def season_games_by_coach(season_id)
    @games.collection.inject(Hash.new(0)) do |count, game|
      if game[1].season == season_id
        count[game[1].home_coach] += 1
        count[game[1].away_coach] += 1
      else
        count[game[1].home_coach] += 0
        count[game[1].away_coach] += 0
      end
      count
    end
  end

  def season_wins_by_coach(season_id)
    @games.collection.inject(Hash.new(0)) do |wins, game|
      if game[1].season == season_id && game[1].home_goals.to_i > game[1].away_goals.to_i
        wins[game[1].home_coach] += 1
      elsif game[1].season == season_id && game[1].away_goals.to_i > game[1].home_goals.to_i
        wins[game[1].away_coach] += 1
      else
        wins[game[1].home_coach] += 0
        wins[game[1].away_coach] += 0
      end
      wins
    end
  end

  def home_wins_by_team
    @games.collection.inject(Hash.new(0)) do |wins, game|
      if game[1].home_goals.to_i > game[1].away_goals.to_i
        wins[game[1].home_team_id] += 1
      end
      wins
    end
  end

  def away_wins_by_team
    @games.collection.inject(Hash.new(0)) do |wins, game|
      if game[1].away_goals.to_i > game[1].home_goals.to_i
        wins[game[1].away_team_id] += 1
      end
      wins
    end
  end

  def goals_by_team
    @games.collection.inject(Hash.new(0)) do |scores, game|
      scores[game[1].home_team_id] += game[1].home_goals.to_i
      scores[game[1].away_team_id] += game[1].away_goals.to_i
      scores
    end
  end

  def home_goals_by_team
    @games.collection.inject(Hash.new(0)) do |scores, game|
      scores[game[1].home_team_id] += game[1].home_goals.to_i
      scores
    end
  end

  def away_goals_by_team
    @games.collection.inject(Hash.new(0)) do |scores, game|
      scores[game[1].away_team_id] += game[1].away_goals.to_i
      scores
    end
  end

  def goals_against_team
    @games.collection.inject(Hash.new(0)) do |scores, game|
      scores[game[1].home_team_id] += game[1].away_goals.to_i
      scores[game[1].away_team_id] += game[1].home_goals.to_i
      scores
    end
  end

  def get_team_name_by_id(team_id)
    @teams.collection[team_id].team_name
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
    elsif !hash.key?(key) && !hash.empty?
      hash[key] = { season_key => season_data }
    elsif hash.empty?
      hash = { key => { season_key => season_data } }
    end
    hash
  end
end
