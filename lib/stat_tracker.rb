require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers:true)
    teams = CSV.read(locations[:teams], headers:true)
    game_teams = CSV.read(locations[:game_teams], headers:true)

    new(games, teams, game_teams)
  end

  def highest_total_score
    highest_score = @games.max_by do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
    highest_score["away_goals"].to_i + highest_score["home_goals"].to_i
  end

  def lowest_total_score
    lowest_score = @games.min_by do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
    lowest_score["away_goals"].to_i + lowest_score["home_goals"].to_i
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game["home_goals"].to_i > game["away_goals"].to_i
    end
    (home_wins.to_f / games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game["away_goals"].to_i > game["home_goals"].to_i
    end
    (visitor_wins.to_f / games.length).round(2)
  end

  def percentage_ties
    tie_games = @games.count do |game|
      game["away_goals"].to_i == game["home_goals"].to_i
    end
    (tie_games.to_f / games.length).round(2)
  end

  def count_of_games_by_season # look into group_by
    games_by_season = {}
    @games.each do |game|
      if games_by_season.keys.include?(game["season"])
        games_by_season[game["season"]] += 1
      else
        games_by_season[game["season"]] = 1
      end
    end
    games_by_season
  end

  def average_goals_per_game
    average_goals = @games.sum do |game|
      game["home_goals"].to_i + game["away_goals"].to_i
    end
    (average_goals.to_f / games.length).round(2)
  end
end
