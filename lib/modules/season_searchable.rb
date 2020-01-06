module SeasonSearchable
  def coach_win_percentages(season_id)
    coach_wins = Hash.new {0}
    season = Season.all.find {|season| season.id.to_s == season_id}
    coach_games = season.games_unsorted.reduce(Hash.new(0)) do |acc, game|
      acc[game.stats.first[1][:Coach]] += 1
      acc[game.stats.to_a.last[1][:Coach]] += 1
      coach_wins[game.winning_coach] += 1
      acc
    end
    win_percentage = coach_games.keys.reduce({}) do |acc, coach, wins|
      acc[coach] = (coach_wins[coach].to_f / coach_games[coach]).round(2)
      acc
    end
  end

  def find_coach_games(season_to_search)
    coach_games = season_to_search.games_unsorted.reduce(Hash.new(0)) do |acc, game|
      acc[game.stats.first[1][:Coach]] += 1
      acc[game.stats.to_a.last[1][:Coach]] += 1
      coach_wins[game.winning_coach] += 1
      acc
    end
  end

  def winningest_coach(season_id)
    percentage_hash = coach_win_percentages(season_id)
    percentage_hash.key(percentage_hash.values.max)
  end

  def worst_coach(season_id)
    percentage_hash = coach_win_percentages(season_id)
    percentage_hash.key(percentage_hash.values.min)
  end

  def team_win_percentage(season_id)
    teams_in_season = teams.find_all {|team| team.stats_by_season.keys.include?(season_id)}
    reg_win_percent = teams_in_season.reduce({}) do |acc, team|
      acc[team.team_name] = team.stats_by_season[season_id][:regular_season][:win_percentage]
      acc
    end
    post_win_percent = teams_in_season.reduce({}) do |acc, team|
      acc[team.team_name] = team.stats_by_season[season_id][:postseason][:win_percentage]
      acc
    end
    win_diff = post_win_percent.reduce({}) do |acc, (team, win)|
      acc[team] = win - reg_win_percent[team]
      acc
    end
  end

  def biggest_bust(season_id)
    teams = team_win_percentage(season_id)
    teams.key(teams.values.min)
  end

  def biggest_surprise(season_id)
    teams = team_win_percentage(season_id)
    teams.key(teams.values.max)
  end

end