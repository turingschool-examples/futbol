require_relative './game'
require 'pry'

class LeagueStatistics

  attr_reader :game_collection, :game_teams_collection, :teams_collection
  def initialize(game_collection, game_teams_collection, teams_collection)
    @game_collection = game_collection
    @game_teams_collection = game_teams_collection
    @teams_collection = teams_collection
  end


  def count_of_teams
    @teams_collection.length
  end

  def best_offense
    max_average = average_goals_by_team.max_by{|team| team}
    best_offense = @teams_collection.find do |team|
      team.id == max_average[0]
    end
    best_offense.team_name
  end

  # Lowest average score all seasons
  def worst_offense
    min_average = average_goals_by_team.min_by{|team| team[1]}
    worst_offense = @teams_collection.find do |team|
      team.id == min_average[0]
    end
    worst_offense.team_name
  end

  def games_played_by_team
    games_by_team = Hash.new(0)
    @game_collection.each do |game|
      games_by_team[game.away_team_id] += 1
      games_by_team[game.home_team_id] += 1
    end
    games_by_team
  end

  def goals_scored_by_team
    goals_by_team = Hash.new(0)
    @game_collection.each do |game|
      goals_by_team[game.away_team_id] += game.away_goals.to_i
      goals_by_team[game.home_team_id] += game.home_goals.to_i
    end
    goals_by_team
  end

  def average_goals(goals_scored, games_played)
    goals_scored/games_played.to_f
  end

  def average_goals_by_team
    team_average_goals = Hash.new(0)
    games_and_goals = games_played_by_team.merge(goals_scored_by_team) { |k, o, n| [o,n]}
    games_and_goals.each do |team|
      team_average_goals[team[0]] = average_goals(team[1][1], team[1][0])
    end
    team_average_goals
  end

  def highest_scoring_visitor
    goals_and_games_by_team_away = Hash.new { |h, k| h[k] = [0,0] }
    team_average_goals_away = Hash.new(0)
    @game_collection.each do |game|
      goals_and_games_by_team_away[game.away_team_id][0] += game.away_goals.to_i
      goals_and_games_by_team_away[game.away_team_id][1] += 1
    end
    goals_and_games_by_team_away.each do |team|
      # Figure out why this is different from the above method
    team_average_goals_away[team[0]] = average_goals(team[1][0], team[1][1])
    end
    max_average = team_average_goals_away.max_by{|team| team[1]}
    highest_scoring_visitor = @teams_collection.find do |team|
      team.id == max_average[0]
    end
    p highest_scoring_visitor.team_name
  end

  def lowest_scoring_visitor
    goals_and_games_by_team_away = Hash.new { |h, k| h[k] = [0,0] }
    team_average_goals_away = Hash.new(0)
    @game_collection.each do |game|
      goals_and_games_by_team_away[game.away_team_id][0] += game.away_goals.to_i
      goals_and_games_by_team_away[game.away_team_id][1] += 1
    end
    goals_and_games_by_team_away.each do |team|
      # Figure out why this is different from the above method
    team_average_goals_away[team[0]] = average_goals(team[1][0], team[1][1])
    end
    min_average = team_average_goals_away.min_by{|team| team[1]}
    lowest_scoring_visitor = @teams_collection.find do |team|
      team.id == min_average[0]
    end
    p lowest_scoring_visitor.team_name
  end


  def highest_scoring_home_team
    goals_and_games_by_team_home = Hash.new { |h, k| h[k] = [0,0] }
    team_average_goals_home = Hash.new(0)
    @game_collection.each do |game|
      goals_and_games_by_team_home[game.home_team_id][0] += game.home_goals.to_i
      goals_and_games_by_team_home[game.home_team_id][1] += 1
    end
    goals_and_games_by_team_home.each do |team|
      # Figure out why this is different from the above method
    team_average_goals_home[team[0]] = average_goals(team[1][0], team[1][1])
    end
    max_average = team_average_goals_home.max_by{|team| team[1]}
    highest_scoring_home_team = @teams_collection.find do |team|
      team.id == max_average[0]
    end
    p highest_scoring_home_team.team_name
  end

  def lowest_scoring_home_team
    goals_and_games_by_team_home = Hash.new { |h, k| h[k] = [0,0] }
    team_average_goals_home = Hash.new(0)
    @game_collection.each do |game|
      goals_and_games_by_team_home[game.home_team_id][0] += game.home_goals.to_i
      goals_and_games_by_team_home[game.home_team_id][1] += 1
    end
    goals_and_games_by_team_home.each do |team|
      # Figure out why this is different from the above method
    team_average_goals_home[team[0]] = average_goals(team[1][0], team[1][1])
    end
    min_average = team_average_goals_home.min_by{|team| team[1]}
    lowest_scoring_home_team = @teams_collection.find do |team|
      team.id == min_average[0]
    end
    p lowest_scoring_home_team.team_name
  end



  # highest_scoring_visitor
  # Name of the team with the highest average score per game across all seasons when they are away.


end
