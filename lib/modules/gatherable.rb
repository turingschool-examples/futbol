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

  def home_goals_by_team
    @game_collection.collection.inject(Hash.new(0)) do |scores, game|
      scores[game[1].home_team_id] += game[1].home_goals.to_i
      scores
    end
  end

  def away_goals_by_team
    @game_collection.collection.inject(Hash.new(0)) do |scores, game|
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
end
