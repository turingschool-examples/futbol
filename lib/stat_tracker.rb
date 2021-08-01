require 'CSV'
require_relative './game_manager'
require_relative './team_manager'
require_relative './game_team_manager'
require_relative './season_manager'

class StatTracker
  attr_reader :game_manager,
              :team_manager,
              :game_team_manager,
              :season_manager

  def initialize(file_paths)
    @game_manager      = GameManager.new(file_paths[:games])
    @team_manager      = TeamManager.new(file_paths[:teams])
    @game_team_manager = GameTeamManager.new(file_paths[:game_teams])
    @season_manager    = SeasonManager.new(@game_manager.seasons, @game_manager.games, @game_team_manager.game_teams)
  end

  def self.from_csv(file_paths)
    StatTracker.new(file_paths)
  end

  def highest_total_score
    game_manager.highest_total_score
  end

  def lowest_total_score
    game_manager.lowest_total_score
  end

  def percentage_home_wins
    game_manager.percentage_home_wins
  end

  def percentage_visitor_wins
    game_manager.percentage_visitor_wins
  end

  def percentage_ties
    game_manager.percentage_ties
  end

  def count_of_games_by_season
    game_manager.count_of_games_by_season
  end

  def average_goals_per_game
    game_manager.average_goals_per_game
  end

  def average_goals_by_season
    game_manager.average_goals_per_season
  end

  # This isn't working yet.
  def winningest_coach(season)
    season_manager.winningest_coach(season)
  end
end






# games = CSV.read(file_paths[:games], headers: true, header_converters: :symbol)
# teams = CSV.read(file_paths[:teams], headers: true, header_converters: :symbol)
# game_teams = CSV.read(file_paths[:game_teams], headers: true, header_converters: :symbol)
# StatTracker.new(games, teams, game_teams)
