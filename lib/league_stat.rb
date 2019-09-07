module LeagueStat

  def count_of_teams
    all_teams.length
  end

  def team_id_and_goals
    @team_id_goals ||= begin
      id_game = {}
      all_game_teams.each do |gameid, game_team_objs|
        id_game[game_team_objs["home"].team_id] ||= Hash.new(0)
        id_game[game_team_objs["home"].team_id][:game_count] += 1
        id_game[game_team_objs["home"].team_id][:goals] += game_team_objs["home"].goals
        id_game[game_team_objs["home"].team_id][:opponent_goals] += game_team_objs["away"].goals
        id_game[game_team_objs["home"].team_id][:goals_when_home] += game_team_objs["home"].goals
        id_game[game_team_objs["home"].team_id][:home_games] += 1
        id_game[game_team_objs["home"].team_id][:home_wins] += 1 if game_team_objs["home"].goals > game_team_objs["away"].goals

        id_game[game_team_objs["away"].team_id] ||= Hash.new(0)
        id_game[game_team_objs["away"].team_id][:game_count] += 1
        id_game[game_team_objs["away"].team_id][:goals] += game_team_objs["away"].goals
        id_game[game_team_objs["away"].team_id][:opponent_goals] += game_team_objs["home"].goals
        id_game[game_team_objs["away"].team_id][:goals_when_away] += game_team_objs["away"].goals
        id_game[game_team_objs["away"].team_id][:away_games] += 1
        id_game[game_team_objs["away"].team_id][:away_wins] += 1 if game_team_objs["away"].goals > game_team_objs["home"].goals
      end
      id_game
    end
  end

  def best_offense
    best_offense = team_id_and_goals.max_by do |id, hash|
      hash[:goals] / hash[:game_count].to_f
    end
    all_teams[best_offense[0]].team_name
  end

  def worst_offense
    worst_offense = team_id_and_goals.min_by do |id, hash|
      hash[:goals] / hash[:game_count].to_f
    end
    all_teams[worst_offense[0]].team_name
  end

  def best_defense
    best_defense = team_id_and_goals.min_by do |id, hash|
      hash[:opponent_goals] / hash[:game_count].to_f
    end
    all_teams[best_defense[0]].team_name
  end

  def worst_defense
    best_defense = team_id_and_goals.max_by do |id, hash|
      hash[:opponent_goals] / hash[:game_count].to_f
    end
    all_teams[best_defense[0]].team_name
  end

  def highest_scoring_visitor
    best_visiting = team_id_and_goals.max_by do |id, hash|
      hash[:goals_when_away] / hash[:away_games].to_f
    end
    all_teams[best_visiting[0]].team_name
  end

  def highest_scoring_home_team
    best_home = team_id_and_goals.max_by do |id, hash|
      hash[:goals_when_home] / hash[:home_games].to_f
    end
    all_teams[best_home[0]].team_name
  end

  def lowest_scoring_visitor
    lowest_visitor = team_id_and_goals.min_by do |id, hash|
      hash[:goals_when_away] / hash[:away_games].to_f
    end
    all_teams[lowest_visitor[0]].team_name
  end

  def lowest_scoring_home_team
    lowest_home = team_id_and_goals.min_by do |id, hash|
      hash[:goals_when_home] / hash[:home_games].to_f
    end
    all_teams[lowest_home[0]].team_name
  end

  def winningest_team
    most_wins = team_id_and_goals.max_by do |id, hash|
      (hash[:away_wins] + hash[:home_wins]) / (hash[:away_games] + hash[:home_games]).to_f
    end
    all_teams[most_wins[0]].team_name
  end

  def best_fans
    helping_fans = team_id_and_goals.max_by do |id, hash|
      (hash[:home_wins] / hash[:home_games].to_f) - (hash[:away_wins] / hash[:away_games].to_f)
    end
    all_teams[helping_fans[0]].team_name
  end

  def worst_fans
    worst_operation = team_id_and_goals.map do |id, hash|
      id if (hash[:home_wins] / hash[:home_games].to_f) < (hash[:away_wins] / hash[:away_games].to_f)
    end
    worst_operation.compact.map do |id|
      all_teams[id].team_name
    end
  end
end
