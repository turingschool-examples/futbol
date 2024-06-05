require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
    attr_reader :games, :teams, :game_teams

    def self.from_csv(locations)
        games = CSV.read(locations[:games], headers: true, header_converters: :symbol)
        teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
        game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

        StatTracker.new(games, teams, game_teams)
    end

    def initialize(games, teams, game_teams)
        @games = games
        @teams = teams
        @game_teams = game_teams
    end

    # Game Statistics
  def highest_total_score
    # Your implementation here
  end

  def lowest_total_score
    # Your implementation here
  end

  def percentage_home_wins
    #  implementation here
  end

  def percentage_visitor_wins
    #  implementation here
  end

  def percentage_ties
    #  implementation here
  end

  def count_of_games_by_season
    #  implementation here
  end

  def average_goals_per_game
    #  implementation here
  end

  def average_goals_by_season
    #  implementation here
  end

  # League Statistics
  def count_of_teams
    #  implementation here
  end

  def best_offense
    #  implementation here
  end

  def worst_offense
    #  implementation here
  end

  def highest_scoring_visitor
    #  implementation here
  end

  def highest_scoring_home_team
    #  implementation here
  end

  def lowest_scoring_visitor
    #  implementation here
  end

  def lowest_scoring_home_team
    #  implementation here
  end

  # Season Statistics
  def winningest_coach(season)
    #  implementation here
  end

  def worst_coach(season)
    #  implementation here
  end

  def most_accurate_team(season)
    #  implementation here
  end

  def least_accurate_team(season)
    #  implementation here
  end

  def most_tackles(season)
    #  implementation here
  end

  def fewest_tackles(season)
    #  implementation here
  end
end