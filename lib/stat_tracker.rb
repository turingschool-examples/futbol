require 'csv'

class StatTracker

  attr_reader :games, :teams, :game_teams
  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.table(locations[:games])
    teams = CSV.table(locations[:teams])
    game_teams = CSV.table(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def total_scores_by_game
    @games.values_at(:away_goals, :home_goals).map do |game|
      game[0] + game[1]
    end
  end

  def lowest_total_score
      total_scores_by_game.min
  end

  def highest_total_score
    total_scores_by_game.max
  end

  def percentage_ties
  
  end

end
