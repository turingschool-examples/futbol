require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'collection'
require_relative 'game_collection'
require_relative 'team_collection'
require_relative 'game_teams_collection'

class StatTracker
  attr_reader :games_collection, :teams_collection, :game_teams_collection

  def self.from_csv(locations)
    games = locations[:games]
    teams = locations[:teams]
    game_teams = locations[:game_teams]

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @games_collection = GameCollection.new(games)
    @teams_collection = TeamCollection.new(teams)
    @game_teams_collection = GameTeamsCollection.new(game_teams)
  end

  def average_goals_per_game
    sum = 0
    @games_collection.collection.each do |game|
      sum += (game[1].away_goals.to_i + game[1].home_goals.to_i)
    end
    (sum.to_f / @games_collection.collection.length).round(2)
  end

  def average_goals_by_season
    sums = {}
    averages = {}
    @games_collection.collection.each do |game|
      if !sums.key?(game[1].season)
        sums[game[1].season] = (game[1].home_goals.to_i + game[1].away_goals.to_i)
      else
        sums[game[1].season] += (game[1].home_goals.to_i + game[1].away_goals.to_i)
      end
    end

    sums.each do |key, value|
      averages[key] = (value.to_f / count_of_games_by_season[key]).round(2)
    end

    averages
  end

  def highest_total_score
    total_scores = @games_collection.collection.map do |game|
      game[1].away_goals.to_i + game[1].home_goals.to_i
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = @games_collection.collection.map do |game|
      game[1].away_goals.to_i + game[1].home_goals.to_i
    end
    total_scores.min
  end

  def biggest_blowout
    blowout = {}
    @games_collection.collection.each do |game|
      margin = (game[1].home_goals.to_i - game[1].away_goals.to_i).abs
      if blowout.empty?
        blowout[game[1]] = margin
      elsif margin > blowout.values[0]
        blowout.clear
        blowout[game[1]] = margin
      end
    end
    blowout.values.last
  end

  def count_of_games_by_season
    season = Hash.new(0)
    @games_collection.collection.each do |game|
      season[game[1].season] += 1
    end
    season
  end

  def percentage_ties
    ties_sum = 0.0
    @games_collection.collection.each do |game|
      ties_sum += 1 if game[1].home_goals == game[1].away_goals
    end
    (ties_sum / @games_collection.collection.length).round(2)
  end

  def percentage_home_wins
    home_wins = 0
    total_games = @games_collection.collection.length

    @games_collection.collection.each do |game|
      if game[1].home_goals.to_i > game[1].away_goals.to_i
        home_wins += 1
      end
    end
    (home_wins / total_games.to_f).abs.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    total_games = @games_collection.collection.length

    @games_collection.collection.each do |game|       
      if game[1].home_goals.to_i < game[1].away_goals.to_i
        visitor_wins += 1
      end
    end
    (visitor_wins / total_games.to_f).abs.round(2)
  end
end
