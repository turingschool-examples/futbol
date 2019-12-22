require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'season'
require_relative 'collection'
require_relative 'game_collection'
require_relative 'team_collection'
require_relative 'game_teams_collection'
require_relative 'season_collection'
require_relative './modules/calculateable'

class StatTracker
  include Calculateable

  attr_reader :game_collection,
              :team_collection,
              :season_collection,
              :game_teams_collection

  def self.from_csv(locations)
    games = locations[:games]
    teams = locations[:teams]
    game_teams = locations[:game_teams]

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @game_collection = GameCollection.new(games)
    @team_collection = TeamCollection.new(teams)
    @season_collection = SeasonCollection.new(games)
    @game_teams_collection = GameTeamsCollection.new(game_teams)
  end

  def average_goals_per_game
    sum = 0
    @game_collection.collection.each do |game|
      sum += (game[1].away_goals.to_i + game[1].home_goals.to_i)
    end
    (sum.to_f / @game_collection.collection.length).round(2)
  end

  def average_goals_by_season
    avg_gpg = Hash.new(0)
    @season_collection.collection.each_pair do |key, season_array|
      season_array.find_all { |game| avg_gpg[key] += (game.home_goals.to_f + game.away_goals.to_f) }
      avg_gpg[key] = (avg_gpg[key] / season_array.length).round(2)
    end
    avg_gpg
  end

  def highest_total_score
    total_scores = @game_collection.collection.map do |game|
      game[1].away_goals.to_i + game[1].home_goals.to_i
    end
    total_scores.max
  end

  def lowest_total_score
    total_scores = @game_collection.collection.map do |game|
      game[1].away_goals.to_i + game[1].home_goals.to_i
    end
    total_scores.min
  end

  def biggest_blowout
    blowout = @game_collection.collection.max_by do |id, game|
      (game.home_goals.to_i - game.away_goals.to_i).abs
    end
    (blowout[1].home_goals.to_i - blowout[1].away_goals.to_i).abs
  end

  def count_of_games_by_season
    @game_collection.collection.reduce(Hash.new{0}) do |hash, game|
      hash[game[1].season] += 1
      hash
    end
  end

  def percentage_ties
    ties_sum = 0.0
    @game_collection.collection.each do |game|
      ties_sum += 1 if game[1].home_goals == game[1].away_goals
    end
    (ties_sum / @game_collection.collection.length).round(2)
  end

  def percentage_home_wins
    home_wins = 0
    total_games = @game_collection.collection.length

    @game_collection.collection.each do |game|
      if game[1].home_goals.to_i > game[1].away_goals.to_i
        home_wins += 1
      end
    end
    (home_wins / total_games.to_f).abs.round(2)
  end

  def percentage_visitor_wins
    visitor_wins = 0
    total_games = @game_collection.collection.length

    @game_collection.collection.each do |game|       
      if game[1].home_goals.to_i < game[1].away_goals.to_i
        visitor_wins += 1
      end
    end
    (visitor_wins / total_games.to_f).abs.round(2)
  end

  def count_of_teams
    @team_collection.collection.length
  end

  def best_offense
    team_id = average_goals(goals_by_team).max_by{ |id, avg| avg }[0]

    @team_collection.collection[team_id].team_name
  end

  def worst_offense
    team_id = average_goals(goals_by_team).min_by{ |id, avg| avg }[0]

    @team_collection.collection[team_id].team_name
  end

  def best_defense
    team_id = average_goals(goals_against_team).min_by{ |id, avg| avg }[0]

    @team_collection.collection[team_id].team_name
  end

  def worst_defense
    team_id = average_goals(goals_against_team).max_by{ |id, avg| avg }[0]

    @team_collection.collection[team_id].team_name
  end
end
