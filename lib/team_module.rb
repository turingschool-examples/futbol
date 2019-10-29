module TeamModule

  def most_goals_scored(team_lookup)
    goals = []
    team_goals = game_teams.reduce({}) do |acc, game_team|
      acc[team_lookup] =  goals << (game_team.team_id == team_lookup ? game_team.goals : 0)
      acc
    end
    team_goals.map { |k, v| v.max }.first
  end

  def fewest_goals_scored(team_lookup)
    goals = []
    team_goals = game_teams.reduce({}) do |acc, game_team|
      acc[team_lookup] =  goals << (game_team.team_id == team_lookup ? game_team.goals : 0)
      acc
    end
    team_goals.map { |k, v| v.min }.first
  end

  def favorite_opponent(team_lookup)
    team_plays = empty_team_hash.transform_values { |k, v| v = empty_team_hash }
    games.each do |game|
      team_plays[game.home_team_id][game.away_team_id] += 1
      team_plays[game.away_team_id][game.home_team_id] += 1
    end
    team_wins = empty_team_hash.transform_values { |k, v| v = empty_team_hash }
    games.each do |game|
      team_wins[game.home_team_id][game.away_team_id] += game.home_goals > game.away_goals ? 1 : 0
      team_wins[game.away_team_id][game.home_team_id] += game.away_goals > game.home_goals ? 1 : 0
    end
    result = team_wins[team_lookup].merge(team_plays[team_lookup]) do |key, oldval, newval|
      if newval == 0
        0
      else
        (oldval.to_f / newval.to_f).round(2)
      end
    end
    id = result.sort_by { |k, v| v }.last.first
    convert_ids_to_team_name(id)
  end

  def rival(team_lookup)
    team_plays = empty_team_hash.transform_values { |k, v| v = empty_team_hash }
    games.each do |game|
      team_plays[game.home_team_id][game.away_team_id] += 1
      team_plays[game.away_team_id][game.home_team_id] += 1
    end
    team_wins = empty_team_hash.transform_values { |k, v| v = empty_team_hash }
    games.each do |game|
      team_wins[game.home_team_id][game.away_team_id] += game.home_goals > game.away_goals ? 1 : 0
      team_wins[game.away_team_id][game.home_team_id] += game.away_goals > game.home_goals ? 1 : 0
    end
    result = team_wins[team_lookup].merge(team_plays[team_lookup]) do |key, oldval, newval|
      if newval == 0
        100
      else
        (oldval.to_f / newval.to_f).round(2)
      end
    end
    id = result.sort_by { |k, v| v }.first.first
    convert_ids_to_team_name(id)
  end



#HELPER METHODS
  def empty_team_hash
    teams_hash = Hash.new
    teams.each {|team| teams_hash[team.team_id] = 0}
    teams_hash
  end

  def convert_ids_to_team_name(id)
    ids_to_name = teams.group_by {|team| team.team_id}.transform_values {|obj| obj[0].teamname}
    ids_to_name[id]
  end

end
