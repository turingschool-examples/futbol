module LeagueStatistics

  def count_of_teams
    @team_table.length
  end

  def team_name_ids
    team_name_per_team_id = {}
    @team_table.each do |team_id, team|
      team_name_per_team_id[team.team_name] = team_id
    end
    team_name_per_team_id
  end

  def best_offense
    team_best_season_average = {}
    team_name_ids.each do |team_name, team_id|
      game_count = 0
      @game_table.each do |game_id, game|
        if team_id.to_i == game.away_team_id && team_best_season_average[team_name].nil?
          team_best_season_average[team_name] = game.away_goals
          game_count += 1
        elsif team_id.to_i == game.home_team_id && team_best_season_average[team_name].nil?
          team_best_season_average[team_name] = game.home_goals
          game_count += 1
        elsif team_id.to_i == game.home_team_id || team_id.to_i == game.away_team_id
          game_count += 1
          team_best_season_average[team_name] += game.away_goals if team_id.to_i == game.away_team_id
          team_best_season_average[team_name] += game.home_goals if team_id.to_i == game.home_team_id
        end
      end
      team_best_season_average[team_name] = team_best_season_average[team_name]/game_count.to_f
    end
    team_best_season_average.key(team_best_season_average.values.max)
  end

  def worst_offense
    team_best_season_average = {}
    team_name_ids.each do |team_name, team_id|
      game_count = 0
      @game_table.each do |game_id, game|
        if team_id.to_i == game.away_team_id && team_best_season_average[team_name].nil?
          team_best_season_average[team_name] = game.away_goals
          game_count += 1
        elsif team_id.to_i == game.home_team_id && team_best_season_average[team_name].nil?
          team_best_season_average[team_name] = game.home_goals
          game_count += 1
        elsif team_id.to_i == game.home_team_id || team_id.to_i == game.away_team_id
          game_count += 1
          team_best_season_average[team_name] += game.away_goals if team_id.to_i == game.away_team_id
          team_best_season_average[team_name] += game.home_goals if team_id.to_i == game.home_team_id
        end
      end
      team_best_season_average[team_name] = team_best_season_average[team_name]/game_count.to_f
    end
    team_best_season_average.key(team_best_season_average.values.min)
  end

# Name of the team with the highest average score per game across all seasons when they are away.
  def highest_scoring_visitor
    team_best_away_average = {}
    team_name_ids.each do |team_name, team_id|
      game_count = 0
      @game_table.each do |game_id, game|
        if team_id.to_i == game.away_team_id && team_best_away_average[team_name].nil?
           team_best_away_average[team_name] = game.away_goals
           game_count += 1
        elsif team_id.to_i == game.away_team_id
          team_best_away_average[team_name] += game.away_goals
          game_count += 1
        end
      end
      team_best_away_average[team_name] = team_best_away_average[team_name]/game_count.to_f
    end
    team_best_away_average.key(team_best_away_average.values.max)
  end

  def highest_scoring_home_team
    team_best_home_average = {}
    team_name_ids.each do |team_name, team_id|
      game_count = 0
      @game_table.each do |game_id, game|
        if team_id.to_i == game.home_team_id && team_best_home_average[team_name].nil?
           team_best_home_average[team_name] = game.home_goals
           game_count += 1
        elsif team_id.to_i == game.home_team_id
          team_best_home_average[team_name] += game.home_goals
          game_count += 1
        end
      end
      team_best_home_average[team_name] = team_best_home_average[team_name]/game_count.to_f
    end
    team_best_home_average.key(team_best_home_average.values.max)
  end

end
