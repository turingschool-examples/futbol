require_relative './stat_tracker'

class GameStatistics
  attr_reader :games, :teams, :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def highest_total_score
    highest_scoring_game =
    @games.max_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    highest_scoring_game.away_goals.to_i + highest_scoring_game.home_goals.to_i
  end

  def lowest_total_score
    lowest_scoring_game =
    @games.min_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    lowest_scoring_game.away_goals.to_i + lowest_scoring_game.home_goals.to_i
  end

  def percentage_home_wins
    (home_team_wins.fdiv(@games.length)).round(2)
  end

  def percentage_visitor_wins
    (visitor_team_wins.fdiv(@games.length)).round(2)
  end

  def percentage_ties
    (ties.fdiv(@games.length)).round(2)
  end

  def home_team_wins
    home_wins =
    @games.count do |game|
      game.home_goals > game.away_goals
    end
    home_wins
  end

  def visitor_team_wins
    visitor_wins =
    @games.count do |game|
      game.home_goals < game.away_goals
    end
    visitor_wins
  end

  def ties
    ties =
    @games.count do |game|
      game.home_goals == game.away_goals
    end
    ties
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    @games.each do |game|
        games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    goals = []
    @games.each do |game|
      goals << game.home_goals.to_i + game.away_goals.to_i
    end
    goals.sum.fdiv(goals.length).round(2)
  end

  def total_goals_by_season
    goals_by_season = Hash.new(0)
    @games.each do |game|
      goals_by_season[game.season] += game.home_goals.to_i + game.away_goals.to_i
    end
    goals_by_season
  end

  def average_goals_by_season
    average_goals_by_season = Hash.new(0)
    total_goals_by_season.each do |season, goals|
      count_of_games_by_season.each do |key, games|
        if season == key
          average_goals_by_season[season] = goals.fdiv(games).round(2)
        end
      end
    end
    average_goals_by_season
  end
end
