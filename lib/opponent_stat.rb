module OpponentStat
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
      opponent_hash[oppo_id] ||= {"WINS" => [], "LOSS" => [], "TIES" => []}
      if game.home_team_id == team_id
        opponent_hash[oppo_id]["WINS"] << game if game.home_goals > game.away_goals
        opponent_hash[oppo_id]["LOSS"] << game if game.home_goals < game.away_goals
        opponent_hash[oppo_id]["TIES"] << game if game.home_goals == game.away_goals
      elsif game.away_team_id == team_id
        opponent_hash[oppo_id]["WINS"] << game if game.away_goals > game.home_goals
        opponent_hash[oppo_id]["LOSS"] << game if game.away_goals < game.home_goals
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

  def favorite_opponent(team_id)
    fav_team = head_to_head(team_id).max_by do |t_name, win_perc|
      win_perc
    end
    fav_team[0]
  end

  def rival(team_id)
    rival_team = head_to_head(team_id).min_by do |t_name, win_perc|
      win_perc
    end
    rival_team[0]
  end
end
