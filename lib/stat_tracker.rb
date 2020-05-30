require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'game_stats'
require_relative 'game_collection'
require_relative 'game_team_collection'
require_relative 'team_collection'
require_relative 'league_stats'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams,
              :game_stats,
              :locations,
              :league_stats

  def self.from_csv(locations)
    games = locations[:games]
    teams = locations[:teams]
    game_teams = locations[:game_teams]

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @game_teams_collection = GameTeamCollection.new("./data/game_teams.csv")
    @games_collection = GameCollection.new("./data/games.csv")
    @teams_collection = TeamCollection.new("./data/teams.csv")
    @game_stats = GameStats.new(@games_collection)
    @locations = {
      games_collection: @games_collection,
      teams_collection: @teams_collection,
      game_teams_collection: @game_teams_collection
      }
    @league_stats = LeagueStats.new(@locations)
  end

  def highest_total_score
    @game_stats.highest_total_score
  end

  def lowest_total_score
    @game_stats.lowest_total_score
  end

  def percentage_home_wins
    @game_stats.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_stats.percentage_visitor_wins
  end

  def percentage_ties
    @game_stats.percentage_ties
  end

  def count_of_games_by_season
    @game_stats.count_of_games_by_season
  end

  def average_goals_per_game
    @game_stats.average_goals_per_game
  end

  def average_goals_by_season
    @game_stats.average_goals_by_season
  end

  def count_of_teams
    @league_stats.count_of_teams
  end

  def best_offense
    @league_stats.best_offense
  end

  def worst_offense
    @league_stats.worst_offense
  end

  def highest_scoring_visitor
    @league_stats.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_stats.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_stats.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_stats.lowest_scoring_home_team
  end
end
