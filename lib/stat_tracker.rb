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
    home_wins = 0
    home_losses = 0
    game_teams = csv_data(@game_teams_path)

    game_teams.each do |game|
      if game[:hoa] == "home" && game[:result] == "WIN"
        home_wins += 1
      elsif game[:hoa] == "home" && game[:result] == "LOSS"
        home_losses += 1
      end
    end

    (100 * home_wins.fdiv(home_wins + home_losses)).round(2)
  end

  def percentage_ties
    ties = 0
    not_ties = 0
    games = csv_data(@game_path)

    games.each do |game|
      if game[:away_goals] == game[:home_goals]
        ties += 1
      else
        not_ties += 1
      end
    end

    (100 * ties.fdiv(ties + not_ties)).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    games = csv_data(@game_path)

    games.each do |game|
      if games_by_season[game[:season]] == nil
        games_by_season[game[:season]] = 1
      else
        games_by_season[game[:season]] += 1
      end
    end

    games_by_season
  end
end
