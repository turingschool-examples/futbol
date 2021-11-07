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


  def away_team_goals_per_game_avg
    away_team_hash = @games.group_by {|game| game.away_team_id}
    away_team_hash.transform_values! {|value| value.count}
    combined_average = away_teams_goals_by_id.merge(away_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
  end

  def home_team_goals_by_id
    home_team_hash = @games.group_by {|game| game.home_team_id}
    home_added_goals = home_team_hash.map {|id, games| games.map {|game| game.home_goals.to_i}.inject(:+)}
    home_hash = Hash[home_team_hash.keys.zip(home_added_goals)]
  end

  def home_team_goals_per_game_avg
    home_team_hash = @games.group_by {|game| game.home_team_id}
    home_team_hash.transform_values! {|value| value.count}
    combined_average = home_team_goals_by_id.merge(home_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
  end

  def team_name_from_id(team_id)
    @teams.select {|team| team.team_id == team_id}.map {|team| team.team_name}[0]
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

  def games_by_season(season)
    games_by_season = @games.group_by {|game| game.season}
    games_by_season.keep_if {|key, value| key == season}
  end

  def game_teams_by_season(season)
    games_by_season = @games.group_by {|game| game.season}
    games_in_season = games_by_season.keep_if {|key, value| key == season}
    season_game_ids = games_in_season.map {|season, games| games.map {|game| game.game_id}}.flatten
    @game_teams.find_all {|games| season_game_ids.include?(games.game_id)}
  end
  #
  # def highest_scoring_home_team
  #   home_team_hash = @games.group_by {|game| game.home_team_id}
  #   home_team_hash.transform_values! {|value| value.count}
  #   combined_average = home_team_goals_by_id.merge(home_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
  #   team_id = combined_average.index(combined_average.values.max)
  #   #require "pry"; binding.pry
  #   return @teams.select {|team| team.team_id == team_id}.map {|team| team.team_name}[0]
  # end
  #
  # def lowest_scoring_visitor
  #   away_team_hash = @games.group_by {|game| game.away_team_id}
  #   away_team_hash.transform_values! {|value| value.count}
  #   combined_average = away_teams_goals_by_id.merge(away_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
  #   team_id = combined_average.index(combined_average.values.min)
  #   return @teams.select {|team| team.team_id == team_id}.map {|team| team.team_name}[0]
  # end
  #
  # def lowest_scoring_home_team
  #   home_team_hash = @games.group_by {|game| game.home_team_id}
  #   home_team_hash.transform_values! {|value| value.count}
  #   combined_average = home_team_goals_by_id.merge(home_team_hash){|key, goals_value, games_value| goals_value.to_f / games_value.to_f}
  #   team_id = combined_average.index(combined_average.values.min)
  #   #require "pry"; binding.pry
  #   return @teams.select {|team| team.team_id == team_id}.map {|team| team.team_name}[0]
  # end
end
