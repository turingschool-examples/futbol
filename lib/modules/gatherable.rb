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

  def wins_by_team(collection)
    collection.inject(Hash.new(0)) do |wins, game|
      if game[1].home_goals.to_i > game[1].away_goals.to_i
        wins[game[1].home_team_id] += 1
      else
        wins[game[1].away_team_id] += 1
      end
      wins
    end
  end

  def season_wins_by_team(collection)
    collection.inject(Hash.new(0)) do |wins, season|
      if season.home_goals.to_i > season.away_goals.to_i
        wins[season.home_team_id] += 1
      end

      if season.away_goals.to_i > season.home_goals.to_i
        wins[season.away_team_id] += 1
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

  def total_season_games_team_id(season_id)
    @seasons.teams.reduce({}) do |hash, season|
      hash[season.first] = season[1][season_id].size
      hash
    end
  end

  def team_season_record(season_id)
    @seasons.teams.reduce({}) do |hash, season|
      team_id = season.first
      team_season = season[1][season_id].flatten
      hash[team_id] = win_lose_draw(season.first, team_season)
      team_season_win_percentage(hash, team_id)
      hash
    end
  end

  def team_season_win_percentage(hash, team_id)
    total_games = (hash[team_id][:win] + hash[team_id][:loss] + hash[team_id][:draw])
    wins = hash[team_id][:win]
    percentage = ((wins.to_f / total_games) * 100).round(2)
    hash[team_id][:win_percentage] = percentage
    hash
  end

  def win_lose_draw(team_id, team_season)
    record = { win: 0, loss: 0, draw: 0, regular_season_games: 0, postseason_games: 0, win_percentage: 0 }
    team_season.reduce({}) do |hash, game|
      if team_id == game.home_team_id && (game.home_goals > game.away_goals)
        record[:win] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      elsif team_id == game.home_team_id && (game.home_goals < game.away_goals)
        record[:loss] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      elsif team_id == game.away_team_id && (game.away_goals > game.home_goals)
        record[:win] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      elsif team_id == game.away_team_id && (game.away_goals < game.home_goals)
        record[:loss] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      elsif game.home_goals == game.away_goals
        record[:draw] += 1
        record[:regular_season_games] += 1 if game.type == 'Regular Season'
        record[:postseason_games] += 1 if game.type == 'Postseason'
      end
      hash = record
      hash
    end
  end

  def team_regular_season_record(season_id)
    @seasons.teams.reduce({}) do |hash, season|
      next(hash) if season[1][season_id].nil?

      team_id = season.first
      team_season = season[1][season_id].flatten
      hash[team_id] = win_lose_draw_regular_season(season.first, team_season)
      team_season_win_percentage(hash, team_id)
      hash
    end
  end

  def win_lose_draw_regular_season(team_id, team_season)
    record = { win: 0, loss: 0, draw: 0, regular_season_games: 0, win_percentage: 0 }
    team_season.reduce({}) do |hash, game|
      if team_id == game.home_team_id && (game.home_goals > game.away_goals) && game.type == 'Regular Season'
        record[:win] += 1
        record[:regular_season_games] += 1
      elsif team_id == game.home_team_id && (game.home_goals < game.away_goals) && game.type == 'Regular Season'
        record[:loss] += 1
        record[:regular_season_games] += 1
      elsif team_id == game.away_team_id && (game.away_goals > game.home_goals) && game.type == 'Regular Season'
        record[:win] += 1
        record[:regular_season_games] += 1
      elsif team_id == game.away_team_id && (game.away_goals < game.home_goals) && game.type == 'Regular Season'
        record[:loss] += 1
        record[:regular_season_games] += 1
      elsif game.home_goals == game.away_goals && game.type == 'Regular Season'
        record[:draw] += 1
        record[:regular_season_games] += 1
      end
      hash = record
      hash
    end
  end

  def team_postseason_record(season_id)
    @seasons.teams.reduce({}) do |hash, season|
      next(hash) if season[1][season_id].nil?

      team_id = season.first
      team_season = season[1][season_id].flatten
      hash[team_id] = win_lose_draw_postseason(season.first, team_season)
      team_season_win_percentage(hash, team_id)
      hash
    end
  end

  def win_lose_draw_postseason(team_id, team_season)
    record = { win: 0, loss: 0, draw: 0, postseason_games: 0, win_percentage: 0 }
    team_season.reduce({}) do |hash, game|
      if team_id == game.home_team_id && (game.home_goals > game.away_goals) && game.type == 'Postseason'
        record[:win] += 1
        record[:postseason_games] += 1
      elsif team_id == game.home_team_id && (game.home_goals < game.away_goals) && game.type == 'Postseason'
        record[:loss] += 1
        record[:postseason_games] += 1
      elsif team_id == game.away_team_id && (game.away_goals > game.home_goals) && game.type == 'Postseason'
        record[:win] += 1
        record[:postseason_games] += 1
      elsif team_id == game.away_team_id && (game.away_goals < game.home_goals) && game.type == 'Postseason'
        record[:loss] += 1
        record[:postseason_games] += 1
      elsif game.home_goals == game.away_goals && game.type == 'Postseason'
        record[:draw] += 1
        record[:postseason_games] += 1
      end
      hash = record
      hash
    end
  end
end
