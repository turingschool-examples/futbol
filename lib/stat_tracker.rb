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
    games = CSV.table(locations[:games], converters: :all)
    teams = CSV.table(locations[:teams], converters: :all)
    game_teams = CSV.table(locations[:game_teams], converters: :all)
    StatTracker.new(games, teams, game_teams)
  end

  def total_scores_per_game
    games[:away_goals].sum + games[:home_goals].sum
  end

  def lowest_total_score
    lowest = @games.min_by do |game|
      game.total_scores_per_game
    end
    lowest.total_scores_per_game
  end
end
