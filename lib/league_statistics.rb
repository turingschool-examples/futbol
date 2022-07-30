class LeagueStatistics
  def initialize(data_set)
    @data_set = data_set
  end

  def count_of_teams
    team_id_array = []
    @data_set[:game_teams].each do |row|
      team_id_array << row[1]
    end
    team_id_array.uniq.count
  end

  def best_offense
    best_team = total_team_goal_stats("all").max_by {|team, average| average}
    return_team_name(best_team[0])
  end

  def worst_offense
    worst_team = total_team_goal_stats("all").min_by {|team, average| average}
    return_team_name(worst_team[0])
  end

  def total_team_goal_stats(hoa_type = nil)
    # hoa_type determines which hash is returned
    # all, home, and away return average goals for the given game type
    # defaults to the raw stats
    teams_goals_stats = Hash.new
    @data_set[:game_teams].each do |row|
      teams_goals_stats[row[:team_id]] = [0, 0, 0, 0]
      # [total_games, goals, home_games, away_games]
    end
    @data_set[:game_teams].each do |row|
      teams_goals_stats[row[:team_id]][0] += 1
      teams_goals_stats[row[:team_id]][1] += row[:goals].to_f
      if row[:hoa] == "home"
        teams_goals_stats[row[:team_id]][2] += 1
      else teams_goals_stats[row[:team_id]][3] += 1
      end
    end
    if hoa_type == "all"
      #total goals average
      teams_goals_stats.each do |team, stat|
        teams_goals_stats[team] = (stat[1] / stat[0]).round(3)
      end
    elsif hoa_type == "home"
      #home goals average
      teams_goals_stats.each do |team, stat|
        teams_goals_stats[team] = (stat[1] / stat[2]).round(3)
      end
    elsif hoa_type == "away"
      #away goals average
      teams_goals_stats.each do |team, stat|
        teams_goals_stats[team] = (stat[1] / stat[3]).round(3)
      end
    else teams_goals_stats
    end
  end

  def return_team_name(team_id)
    team_name = ""
    @data_set[:teams].each do |row|
      if row[:team_id] == team_id
        team_name = row[:teamname]
      end
    end
    return team_name
  end
end
