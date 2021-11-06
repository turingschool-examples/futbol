module TeamStats
  def season_games(team_id)
     win_loss = {}
     creator.games_hash.map do |game|
      if game[1].away_team_id == team_id
        win_loss[game[1].season] ||= []
        win_loss[game[1].season].push(game[1].away_team_stat.result)
      elsif game[1].home_team_id == team_id
        win_loss[game[1].season] ||= []
        win_loss[game[1].season].push(game[1].home_team_stat.result)
      end
    end
    win_loss
  end

  def team_info(team_id)
    @teams = creator.teams_hash
    info = {}
    info["team_id"] = @teams[team_id].team_id
    info["franchise_id"] = @teams[team_id].franchise_id
    info["team_name"] = @teams[team_id].team_name
    info["abbreviation"] = @teams[team_id].abbreviation
    info["link"] = @teams[team_id].link
    info
  end
  def best_season(team_id)
    best = season_games(team_id).max_by do |k,v|
      v.count("WIN") / v.length
    end
    best[0]
  end

  def worst_season(team_id)
    worst = season_games(team_id).max_by do |k,v|
      v.count("LOSS") / v.length
    end
    worst[0]
  end

  def average_win_percentage(team_id)
    win_loss = []
    creator.games_hash.each_value do |game|
      if game.away_team_id == team_id
        win_loss.push(game.away_team_stat.result)
      elsif game.home_team_id == team_id
        win_loss.push(game.home_team_stat.result)
      end
    end
    (win_loss.count("WIN") / win_loss.length.to_f) * 100
  end
  def goals_scored(team_id)
    goals_scored = []
    creator.games_hash.each_value do |game|
      if game.away_team_id == team_id
        goals_scored.push(game.away_goals)
      elsif game.home_team_id == team_id
        goals_scored.push(game.home_goals)
      end
    end
    goals_scored
  end

  def most_goals_scored(team_id)
    goals_scored(team_id).max
  end

  def fewest_goals_scored(team_id)
    goals_scored(team_id).min
  end
  def opponent(team_id)
    win_loss = {}
    creator.games_hash.each do |game|
      if game[1].away_team_id == team_id
        win_loss[game[1].home_team_id] ||= []
        win_loss[game[1].home_team_id].push(game[1].home_team_stat.result)
      elsif game[1].home_team_id == team_id
        win_loss[game[1].away_team_id] ||= []
        win_loss[game[1].away_team_id].push(game[1].away_team_stat.result)
      end
    end
    win_loss
  end
  def favorite_opponent(team_id)
    favorite = opponent(team_id).max_by do |k,v|
      v.count("WIN") / v.length
    end
    favorite_name = creator.teams_hash.select {|team|  team[0] == favorite[0]}
    favorite_name.values[0].team_name
  end

  def rival(team_id)
    rival_team = opponent(team_id).min_by do |k,v|
      v.count("WIN") / v.length
    end
    rival_name = creator.teams_hash.select {|team|  team[0] == rival_team[0]}
    rival_name.values[0].team_name
  end
end
