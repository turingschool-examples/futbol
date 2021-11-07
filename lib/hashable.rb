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

  def highest_scoring_visitor
    away_team_hash = @games.group_by {|game| game.away_team_id}
    away_team_hash.transform_values! {|value| value.count}
    combined_average = away_teams_goals_by_id.merge(away_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
    team_id = combined_average.index(combined_average.values.max)
    return @teams.select {|team| team.team_id == team_id}.map {|team| team.team_name}[0]
  end

  def highest_scoring_home_team
    home_team_hash = @games.group_by {|game| game.home_team_id}
    home_team_hash.transform_values! {|value| value.count}
    combined_average = home_team_goals_by_id.merge(home_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
    team_id = combined_average.index(combined_average.values.max)
    #require "pry"; binding.pry
    return @teams.select {|team| team.team_id == team_id}.map {|team| team.team_name}[0]
  end

  def lowest_scoring_visitor
    away_team_hash = @games.group_by {|game| game.away_team_id}
    away_team_hash.transform_values! {|value| value.count}
    combined_average = away_teams_goals_by_id.merge(away_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
    team_id = combined_average.index(combined_average.values.min)
    return @teams.select {|team| team.team_id == team_id}.map {|team| team.team_name}[0]
  end

  def lowest_scoring_home_team
    home_team_hash = @games.group_by {|game| game.home_team_id}
    home_team_hash.transform_values! {|value| value.count}
    combined_average = home_team_goals_by_id.merge(home_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
    team_id = combined_average.index(combined_average.values.min)
    #require "pry"; binding.pry
    return @teams.select {|team| team.team_id == team_id}.map {|team| team.team_name}[0]
  end
end
