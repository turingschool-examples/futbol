require './lib/game_teams'
require './lib/teams'
require './lib/games'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(game_teams, games, teams)
    @game_teams = game_teams
    @games = games
    @teams = teams
  end

  def self.from_csv(locations)
    game_teams = GameTeams.create(locations[:game_teams])
    games = Games.create(locations[:games])
    teams =  Teams.create(locations[:teams])
    self.new(game_teams, games, teams)
  end

##games methods for iteration 2

  def highest_total_score
    games.max_by do |game|
      game.away_goals + game.home_goals
    end
  end

  def lowest_total_score
    games.min_by do |game|
      game.away_goals + game.home_goals
    end
  end

  def biggest_blowout
    games.max_by do |game|
      (game.away_goals - game.home_goals).abs
    end
  end

  def percentage_home_wins
  end

  def percentage_visitor_wins
  end

  def percentage_ties
  end

  def count_of_games_by_season
  end

  def average_goals_per_game
  end

  def average_goals_by_season
  end

end
