
require "csv"
require "./lib/game_collection"
require "./lib/team_collection"
require "./lib/game_team_collection"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @games.all
  end

  def teams
    @teams.all
  end

  def game_teams
    @game_teams.all
  end

  # Game statistics
  def highest_total_score
    games.max_by do |game|
      game.total_goals
    end.total_goals
  end

  def lowest_total_score
    games.min_by do |game|
      game.total_goals
    end.total_goals
  end

  def percentage_home_wins
    home_win_total = games.count do |game|
      game.home_goals > game.away_goals
    end.to_f
    (home_win_total / games.count).round(2)
  end

  def percentage_visitor_wins
    away_win_total = games.count do |game|
       game.away_goals > game.home_goals
    end.to_f
    (away_win_total / games.count).round(2)
  end

  def percentage_ties
    tie_total = games.count do |game|
      game.home_goals == game.away_goals
    end.to_f
    (tie_total / games.count).round(2)
  end

  def count_of_games_by_season
    games.reduce(Hash.new(0)) do |hash, game|
      hash[game.season] += 1
      hash
    end
  end

  def average_goals_per_game
    all_goals = 0.00
    games.each do |game|
      all_goals += game.home_goals
      all_goals += game.away_goals
    end
    (all_goals / games.count).round(2)
  end

  def average_goals_by_season
    goals = games.reduce(Hash.new(0)) do |hash, game|
      hash[game.season] += game.total_goals
      hash
    end
    goals.merge(count_of_games_by_season) do |season, goal_count, game_count|
      ((goal_count.to_f) / (game_count.to_f)).round(2)
    end
  end

end
