module TeamStats
  
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
    win_loss = {}
    creator.games_hash.each do |game|
      if game[1].away_team_id == team_id
        win_loss[game[1].season] ||= []
        win_loss[game[1].season].push(game[1].away_team_stat.result)
      elsif game[1].home_team_id == team_id
        win_loss[game[1].season] ||= []
        win_loss[game[1].season].push(game[1].home_team_stat.result)
      end
    end
    best = win_loss.max_by do |k,v|
      v.count("WIN") / v.length
    end
    best[0]
  end

  def worst_season(team_id)
    win_loss = {}
    creator.games_hash.each do |game|
      if game[1].away_team_id == team_id
        win_loss[game[1].season] ||= []
        win_loss[game[1].season].push(game[1].away_team_stat.result)
      elsif game[1].home_team_id == team_id
        win_loss[game[1].season] ||= []
        win_loss[game[1].season].push(game[1].home_team_stat.result)
      end
    end
    best = win_loss.max_by do |k,v|
      v.count("LOSS") / v.length
    end
    best[0]
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

  def most_goals_scored(team_id)
    goals_scored = []
    creator.games_hash.each_value do |game|
      if game.away_team_id == team_id
        goals_scored.push(game.away_goals)
      elsif game.home_team_id == team_id
        goals_scored.push(game.home_goals)
      end
    end
    goals_scored.max
  end

  def fewest_goals_scored(team_id)
    goals_scored = []
    creator.games_hash.each_value do |game|
      if game.away_team_id == team_id
        goals_scored.push(game.away_goals)
      elsif game.home_team_id == team_id
        goals_scored.push(game.home_goals)
      end
    end
    goals_scored.min
  end

  def favorite_opponent(team_id)
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
    best = win_loss.max_by do |k,v|
      v.count("WIN") / v.length
    end
    # require "pry"; binding.pry
    fav = creator.teams_hash.select {|team|  team[0] == best[0]}
    fav.values[0].team_name
  end

  def rival(team_id)
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
    best = win_loss.min_by do |k,v|
      v.count("WIN") / v.length
    end
    rival = creator.teams_hash.select {|team|  team[0] == best[0]}
    rival.values[0].team_name
  end
end
