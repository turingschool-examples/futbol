module SeasonStat

  def opponents(team_id)
    opponent_hash = Hash.new
    relavent_games = all_games.values.find_all do |game_obj|
      game_obj.away_team_id == team_id || game_obj.home_team_id == team_id
    end
    relavent_games.each do |game|
      oppo_id = nil
      if game.home_team_id != team_id
        oppo_id = game.home_team_id
      else
        oppo_id = game.away_team_id
      end
      opponent_hash[oppo_id] ||= Hash.new
      if game.home_team_id == team_id
        opponent_hash[oppo_id]["WINS"] ||= Array.new
        opponent_hash[oppo_id]["WINS"] << game if game.home_goals > game.away_goals
        opponent_hash[oppo_id]["LOSS"] ||= Array.new
        opponent_hash[oppo_id]["LOSS"] << game if game.home_goals < game.away_goals
        opponent_hash[oppo_id]["TIES"] ||= Array.new
        opponent_hash[oppo_id]["TIES"] << game if game.home_goals == game.away_goals
      elsif game.away_team_id == team_id
        opponent_hash[oppo_id]["WINS"] ||= Array.new
        opponent_hash[oppo_id]["WINS"] << game if game.away_goals > game.home_goals
        opponent_hash[oppo_id]["LOSS"] ||= Array.new
        opponent_hash[oppo_id]["LOSS"] << game if game.away_goals < game.home_goals
        opponent_hash[oppo_id]["TIES"] ||= Array.new
        opponent_hash[oppo_id]["TIES"] << game if game.away_goals == game.home_goals
      end
    end
    opponent_hash
  end

  def head_to_head(team_id)
    win_perc_hash = Hash.new
    opponents(team_id).each do |oppo_id, hash|
      win_perc_hash[all_teams[oppo_id].team_name] = (hash["WINS"].length / hash.values.flatten.length.to_f).round(2)
    end
    win_perc_hash
  end

  def team_info(team_id)
    team_info_hash = Hash.new
    team_info_hash["team_id"] = team_id
    team_info_hash["franchise_id"] = all_teams[team_id].franchise_id
    team_info_hash["team_name"] = all_teams[team_id].team_name
    team_info_hash["abbreviation"] = all_teams[team_id].abbreviation
    team_info_hash["link"] = all_teams[team_id].link
    team_info_hash
  end

  def seasons_to_game_teams(team_id)
    team_game_id = 0
    season_games = Hash.new
    all_game_teams.each do |game_id, hash_pair|
      hash_pair.each do |key, game_team_obj|
        if team_id == game_team_obj.team_id
          team_game_id = game_team_obj.game_id
          season_games[all_games[team_game_id].season] ||= []
          season_games[all_games[team_game_id].season] << game_team_obj
        end
      end
    end
    season_games
  end

  def best_season(team_id)
    best_season_var = seasons_to_game_teams(team_id).max_by do |season, array_gameteams|
      wins = array_gameteams.count do |game_team_obj|
        game_team_obj.result == "WIN"
      end
      total_games = array_gameteams.count do |game_team_obj|
        game_team_obj
      end
      wins / total_games.to_f
    end
    best_season_var[0]
  end

  def worst_season(team_id)
    worst_season_var = seasons_to_game_teams(team_id).min_by do |season, array_gameteams|
      wins = array_gameteams.count do |game_team_obj|
        game_team_obj.result == "WIN"
      end
      total_games = array_gameteams.count do |game_team_obj|
        game_team_obj
      end
      wins / total_games.to_f
    end
    worst_season_var[0]
  end

  def average_win_percentage(team_id)
    wins = []
    games = []
    all_game_teams.each do |game_id, hash_pair|
      hash_pair.each do |key, game_team_obj|
        if team_id == game_team_obj.team_id
          if game_team_obj.result == "WIN"
            wins << game_team_obj
          end
          games << game_team_obj
        end
      end
    end
    (wins.length / games.length.to_f).round(2)
  end

  def most_goals_scored(team_id)
    all_games_for_team = seasons_to_game_teams(team_id).values.flatten
    highest_scoring_game = all_games_for_team.max_by do |game_team_obj|
      game_team_obj.goals
    end
    highest_scoring_game.goals
  end

  def fewest_goals_scored(team_id)
    all_games_for_team = seasons_to_game_teams(team_id).values.flatten
    lowest_scoring_game = all_games_for_team.min_by do |game_team_obj|
      game_team_obj.goals
    end
    lowest_scoring_game.goals
  end
end
