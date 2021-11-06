require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './stat_tracker.rb'
class League
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(data)
    @games = data[:games]
    @teams = data[:teams]
    @game_teams = data[:game_teams]
  end

  def highest_total_score

    game_id_hash = @game_teams.group_by do |game_team|
      game_team.game_id
    end

    sum_of_goals_each_game = []
    game_id_hash.each_pair do |key, value|
      sum_of_goals_each_game << value[0].goals.to_i + value[1].goals.to_i
    end
    sum_of_goals_each_game.max
  end

  def lowest_total_score

    game_id_hash = @game_teams.group_by do |game_team|
      game_team.game_id
    end

    sum_of_goals_each_game = []
    game_id_hash.each_pair do |key, value|
      sum_of_goals_each_game << value[0].goals.to_i + value[1].goals.to_i
    end
    sum_of_goals_each_game.min
  end

  def count_of_teams
    @teams.count
  end

  def percentage_home_wins
    home_games = @game_teams.find_all do |game_team|
      game_team.home_or_away["home"]
    end
    home_game_wins = @game_teams.find_all do |game_team|
      game_team.home_or_away["home"] && game_team.result == "WIN"
    end
    ((home_game_wins.length.to_f)/(home_games.length.to_f)).round(2)
  end

  def percentage_away_wins
    away_games = @game_teams.find_all do |game_team|
      game_team.home_or_away["away"]
    end
    away_game_wins = @game_teams.find_all do |game_team|
      game_team.home_or_away["away"] && game_team.result["WIN"]
    end
    ((away_game_wins.length.to_f)/(away_games.length.to_f)).round(2)
  end

  def percentage_ties
    tie_games = @game_teams.select {|game| game.result == "TIE"}
    ((tie_games.count / 2.0) / (@game_teams.count / 2.0)).round(2)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by {|game| game.season}
    games_by_season.transform_values! {|value| value.count}
  end

  def combined_hash_team_goals
    away_team_hash = @games.group_by {|game| game.away_team_id}
    away_added_goals = away_team_hash.map {|id, games| games.map {|game| game.away_goals.to_i}.inject(:+)}
    away_hash = Hash[away_team_hash.keys.zip(away_added_goals)]
    home_team_hash = @games.group_by {|game| game.home_team_id}
    home_added_goals = home_team_hash.map {|id, games| games.map {|game| game.home_goals.to_i}.inject(:+)}
    home_hash = Hash[home_team_hash.keys.zip(home_added_goals)]
    home_hash.merge(away_hash){|key, home_value, away_value| home_value + away_value}
  end

  def best_offense
    highest_scoring_team = combined_hash_team_goals.index(combined_hash_team_goals.values.max)
    best_team = @teams.find {|team| team.team_id == highest_scoring_team}
    best_team.team_name
  end

  def worst_offense
    lowest_scoring_team = combined_hash_team_goals.index(combined_hash_team_goals.values.min)
    worst_team = @teams.find {|team| team.team_id == lowest_scoring_team}
    worst_team.team_name
  end

end
