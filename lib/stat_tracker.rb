require 'csv'
require './lib/game'
require './lib/team'
require './lib/game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(stats)
    @games = stats[:games]
    @teams = stats[:teams]
    @game_teams = stats[:game_teams]
  end

  def self.from_csv(locations)
    stats = {}
    stats[:games] = create_game_csv(locations)
    stats[:teams] = create_teams_csv(locations)
    stats[:game_teams] = create_game_teams_csv(locations)

    StatTracker.new(stats)

  end

  def self.create_game_csv(locations)
    games = []
    game_csv = CSV.foreach(locations[:games], headers: true) do |row|
      game = Game.new(row)
      games << game
    end
    games
  end

  def self.create_teams_csv(locations)
    teams = []
    team_csv = CSV.foreach(locations[:teams], headers: true) do |row|
      team = Team.new(row)
      teams << team
    end
    teams
  end

  def self.create_game_teams_csv(locations)
    game_teams = []
    game_team_csv = CSV.foreach(locations[:game_teams], headers: true) do |row|
      game_team = GameTeam.new(row)
      game_teams << game_team
    end
    game_teams
  end
# GAME STATISTICS
  def highest_total_score
    game_sums = @games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.max
  end

  def lowest_total_score
    game_sums = @games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.min
  end

  def percentage_home_wins
    home_wins = @games.find_all do |game|
      game.home_goals > game.away_goals
    end.length
    (home_wins.to_f / (games.length)).round(2)
  end

  def percentage_visitor_wins
    vistor_wins = @games.find_all do |game|
      game.away_goals > game.home_goals
    end.length
    (vistor_wins.to_f / (games.length)).round(2)
  end

  def percentage_ties
    ties = @games.find_all do |game|
      game.away_goals == game.home_goals
    end.length
    (ties.to_f / (games.length)).round(2)
  end

  def count_of_games_by_season
    count = {}
    @games.each do |game|
      if count[game.season.to_s].nil?
        count[game.season.to_s] = 1
      else
        count[game.season.to_s] += 1
      end
    end
    count
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
      game.away_goals + game.home_goals
    end
    (total_goals.to_f / (@games.length)).round(2)
  end

  def average_goals_by_season
    hash = {}
    @games.each do |game|
      if hash[game.season].nil?
        hash[game.season] = [1, game.home_goals + game.away_goals]
      else
        hash[game.season][0] += 1
        hash[game.season][1] += game.home_goals + game.away_goals
      end
    end
    results = {}
    hash.each do |season, stats|
      results[season.to_s] = (stats[1].to_f / stats[0]).round(2)
    end
    results
  end
end
