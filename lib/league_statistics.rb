require_relative './statistics'
require_relative './mathable'

class LeagueStatistics < Statistics
  include Mathable

  attr_reader :game_collection, :game_teams_collection, :teams_collection

  def count_of_teams
    @teams_collection.length
  end

  def best_worst_offense(high_low)
    max_average = average_goals_by_team.max_by{|team| team[1]}
    min_average = average_goals_by_team.min_by{|team| team[1]}
    if high_low == :high
    best_offense = @teams_collection.find do |team|
      team.id == max_average[0]
      end
    best_offense.team_name
    elsif high_low == :low
    worst_offense = @teams_collection.find do |team|
      team.id == min_average[0]
      end
      worst_offense.team_name
    end
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

  def average_goals_by_team
    team_average_goals = Hash.new(0)
    games_and_goals = games_played_by_team.merge(goals_scored_by_team) { |k, o, n| [o,n]}
    games_and_goals.each do |team|
      # team[1][1] -> goals scored | team[1][0] -> games played
      team_average_goals[team[0]] = average(team[1][1],team[1][0].to_f)
    end
    team_average_goals
  end

  def highest_scoring_visitor
    max_average = away_home_team_scores(:away).max_by{|team| team[1]}
    highest_scoring_visitor = @teams_collection.find do |team|
      team.id == max_average[0]
    end
    highest_scoring_visitor.team_name
  end

  def lowest_scoring_visitor
    min_average = away_home_team_scores(:away).min_by{|team| team[1]}
    lowest_scoring_visitor = @teams_collection.find do |team|
      team.id == min_average[0]
    end
    lowest_scoring_visitor.team_name
  end

  def away_home_team_scores(away_home)
    if away_home == :away
      away_team_average_helper
    elsif away_home == :home
      home_team_average_helper
    end
  end


  def highest_scoring_home_team
    max_average = away_home_team_scores(:home).max_by{|team| team[1]}
    highest_scoring_home_team = @teams_collection.find do |team|
      team.id == max_average[0]
    end
    highest_scoring_home_team.team_name
  end

  def lowest_scoring_home_team
    min_average = away_home_team_scores(:home).min_by{|team| team[1]}
    lowest_scoring_home_team = @teams_collection.find do |team|
      team.id == min_average[0]
    end
    lowest_scoring_home_team.team_name
  end

  def away_team_average_helper
    goals_and_games_by_team_away = Hash.new { |h, k| h[k] = [0,0] }
    team_average_goals_away = Hash.new(0)
    @game_collection.each do |game|
      goals_and_games_by_team_away[game.away_team_id][0] += game.away_goals.to_i
      goals_and_games_by_team_away[game.away_team_id][1] += 1
      end
    goals_and_games_by_team_away.each do |team|
    team_average_goals_away[team[0]] = average(team[1][0], team[1][1].to_f)
      end
    team_average_goals_away
  end

  def home_team_average_helper
    goals_and_games_by_team_home = Hash.new { |h, k| h[k] = [0,0] }
    team_average_goals_home = Hash.new(0)
    @game_collection.each do |game|
      goals_and_games_by_team_home[game.home_team_id][0] += game.home_goals.to_i
      goals_and_games_by_team_home[game.home_team_id][1] += 1
      end
    goals_and_games_by_team_home.each do |team|
    team_average_goals_home[team[0]] = average(team[1][0], team[1][1].to_f)
      end
    team_average_goals_home
  end
end
