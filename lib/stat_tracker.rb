require 'csv'
require './lib/game_teams_collection'
require './lib/game_collection'
require './lib/team_collection'

class StatTracker

  def self.from_csv(locations)
    raw_data = {}
    raw_data[:game_data] = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    raw_data[:team_data] = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    raw_data[:game_teams_data] = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    StatTracker.new(raw_data)
  end

  attr_reader :game_collection, :team_collection, :gtc
  def initialize(raw_data)
    @game_data = raw_data[:game_data]
    @team_data = raw_data[:team_data]
    @game_teams_data = raw_data[:game_teams_data]
    @gtc = nil
    @game_collection = nil
    @team_collection = nil
    construct_collections
  end

  def construct_collections
    @gtc = GameTeamsCollection.new(@game_teams_data)
    @game_collection = GameCollection.new(@game_data)
    @team_collection = TeamCollection.new(@team_data)
  end

  def highest_total_score
    game_collection.games.map do |game|
      game.home_goals + game.away_goals
    end.max
  end

  def biggest_blowout
    game_collection.games.map do |game|
      Math.sqrt((game.home_goals - game.away_goals)**2).to_i
    end.max
  end

  def percentage_ties
    ties = game_collection.games.find_all do |game|
      game.home_goals == game.away_goals
    end.length
    (ties / game_collection.games.length.to_f).round(2)
  end

  def count_of_games_by_season
    games_in_season = Hash.new(0)
    game_collection.games.each do |game|
        games_in_season[game.season] += 1
    end
    games_in_season
  end

  def lowest_total_score
    game_collection.games.map do |game|
      game.home_goals + game.away_goals
    end.min
  end

  def average_goals_per_game
    total_goals_per_game = game_collection.games.map do |game|
      game.home_goals + game.away_goals
    end
    (total_goals_per_game.sum.to_f / game_collection.games.length).round(2)
  end

  def average_goals_by_season
    games_grouped_by_season = game_collection.games.group_by do |game|
      game.season
    end
    games_grouped_by_season.each_pair do |season, games_by_season|
      total_goals = games_by_season.map do |single_game|
        single_game.home_goals + single_game.away_goals
      end
    average = (total_goals.sum.to_f / total_goals.length).round(2)
    games_grouped_by_season[season] = average
    end
  end

  def percentage_visitor_wins
    visitor_wins = game_collection.games.find_all do |game|
      game.away_goals > game.home_goals
    end
    (visitor_wins.length.to_f / game_collection.games.length).round(2)
  end

  def percentage_home_wins
    home_wins = game_collection.games.find_all do |game|
      game.home_goals > game.away_goals
    end
    (home_wins.length.to_f / game_collection.games.length).round(2)
  end
end
