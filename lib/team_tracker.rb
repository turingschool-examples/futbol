class TeamTracker < Statistics
  # USE THIS METHOD TEAM INFO
  def team_info(team_id)
    team_hash = {}
    team = @teams.find do |team|
      team.team_id == team_id
    end
    team.instance_variables.each do |variable|
      variable = variable.to_s.delete! '@'
      team_hash[variable.to_sym] = team.instance_variable_get("@#{variable}".to_sym)
    end
    team_hash
  end


  def best_season(team_id)
    all_games = @games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    # reg_games = all_games.find_all do |game|
    #   game.type == "Regular Season"
    # end
    games_by_season = all_games.group_by do |game|
      game.season
    end
    win_hash = Hash.new { |hash, key| hash[key] = [] }
    games_by_season.each_pair do |season, games|
      games.each do |game|
        @game_teams.find_all do |game_2|
          win_hash[season] << game_2 if game.game_id == game_2.game_id && game_2.team_id == team_id
        end
      end
    end
    hash = Hash.new
    win_hash.each_pair do |season, games|
      wins = games.count do |game|
        game.result == "WIN"
      end
      hash[season] = wins.to_f / win_hash[season].length
    end
    hash.key(hash.values.max)
  end

  def worst_season(team_id)
    all_games = @games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    # reg_games = all_games.find_all do |game|
    #   game.type == "Regular Season"
    # end
    games_by_season = all_games.group_by do |game|
      game.season
    end
    win_hash = Hash.new { |hash, key| hash[key] = [] }
    games_by_season.each_pair do |season, games|
      games.each do |game|
        @game_teams.find_all do |game_2|
          win_hash[season] << game_2 if game.game_id == game_2.game_id && game_2.team_id == team_id
        end
      end
    end
    hash = Hash.new
    win_hash.each_pair do |season, games|
      wins = games.count do |game|
        game.result == "WIN"
      end
      hash[season] = wins.to_f / win_hash[season].length
    end
    hash.key(hash.values.min)
  end

  def average_win_percentage(team_id)
    all_games = @games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    games_by_season = all_games.group_by do |game|
      game.season
    end
    win_hash = Hash.new { |hash, key| hash[key] = [] }
    games_by_season.each_pair do |season, games|
      games.each do |game|
        @game_teams.find_all do |game_2|
          win_hash[season] << game_2 if game.game_id == game_2.game_id && game_2.team_id == team_id
        end
      end
    end
    hash = Hash.new
    win_hash.each_pair do |season, games|
      wins = games.count do |game|
        game.result == "WIN"
      end
      hash[season] = (wins.to_f / win_hash[season].length).round(2)
    end
    ((hash.values.sum) / hash.values.length).round(2)
  end

  def most_goals_scored(team_id)
    team_goal_max = @game_teams.find_all do |game|
      game.team_id == team_id
    end
    game = team_goal_max.max_by do |game|
      game.goals
    end
    game.goals
  end

  def fewest_goals_scored(team_id)
    team_goal_min = @game_teams.find_all do |game|
      game.team_id == team_id
    end
    game = team_goal_min.min_by do |game|
      game.goals
    end
    game.goals
  end

  def favorite_opponent(team_id)
    all_games = @games.find_all do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    won_games = @game_teams.find_all{|game|game.result == "WIN"}
    filtered_games = []
    all_games.each do |game|
      won_games.each do |won_game|
        filtered_games << game if game.game_id == won_game.game_id
      end
    end
    filtered_games
    require "pry"; binding.pry
  end

end
