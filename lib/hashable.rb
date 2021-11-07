module Hashable
  def combined_hash_team_goals
    away_team_hash = @games.group_by {|game| game.away_team_id}
    away_added_goals = away_team_hash.map {|id, games| games.map {|game| game.away_goals.to_i}.inject(:+)}
    away_hash = Hash[away_team_hash.keys.zip(away_added_goals)]
    home_team_hash = @games.group_by {|game| game.home_team_id}
    home_added_goals = home_team_hash.map {|id, games| games.map {|game| game.home_goals.to_i}.inject(:+)}
    home_hash = Hash[home_team_hash.keys.zip(home_added_goals)]
    home_hash.merge(away_hash){|key, home_value, away_value| home_value + away_value}
  end

  def total_games
    away_team_hash = @games.group_by {|game| game.away_team_id}
    away_count_hash = away_team_hash.transform_values {|value| value.count}
    home_team_hash = @games.group_by {|game| game.home_team_id}
    home_count_hash = home_team_hash.transform_values {|value| value.count}
    home_count_hash.merge(away_count_hash){|key, home_value, away_value| home_value + away_value}
  end

  def averaging_hash
    combined_hash_team_goals.merge(total_games){|key, goals, games| goals.to_f / games.to_f}
  end



  def away_teams_goals_by_id
    away_team_hash = @games.group_by {|game| game.away_team_id}
    away_added_goals = away_team_hash.map {|id, games| games.map {|game| game.away_goals.to_i}.inject(:+)}
    away_hash = Hash[away_team_hash.keys.zip(away_added_goals)]
  end

  def home_team_goals_by_id
    home_team_hash = @games.group_by {|game| game.home_team_id}
    home_added_goals = home_team_hash.map {|id, games| games.map {|game| game.home_goals.to_i}.inject(:+)}
    home_hash = Hash[home_team_hash.keys.zip(home_added_goals)]
  end

  def combined_goals_by_team_id
    home_team_goals_by_id.merge(away_teams_goals_by_id){|key, home_value, away_value| home_value + away_value}
  end
end
