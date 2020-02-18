require 'csv'
require './lib/data_module'

class StatTracker
  include DataLoadable
  attr_accessor :game_path, :team_path, :game_teams_path

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_path = locations[:games]
    @team_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
  end

  def percentage_home_wins
    game_teams = csv_data(@game_teams_path)

    home_wins = game_teams.count do |game|
      game[:hoa] == "home" && game[:result] == "WIN"
    end

    home_games = game_teams.count do |game|
      game[:hoa] == "home"
    end

    (100 * home_wins.fdiv(home_games)).round(2)
  end

  def percentage_ties
    games = csv_data(@game_path)

    ties = games.count do |game|
      game[:away_goals] == game[:home_goals]
    end

    (100 * ties.fdiv(games.length)).round(2)
  end

  def count_of_games_by_season
    games = csv_data(@game_path)

    games.reduce(Hash.new(0)) do |games_by_season, game|
      games_by_season[game[:season]] += 1
      games_by_season
    end
  end
end
