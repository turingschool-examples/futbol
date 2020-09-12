require 'csv'
require_relative '../lib/game_manager'
require_relative '../lib/team_manager'
require_relative '../lib/game_teams_manager'
require_relative '../lib/game'
require_relative '../lib/team'
require_relative '../lib/game_teams'
require_relative '../lib/findable'
require_relative '../lib/league_stats'

class StatTracker
  include Findable
  include LeagueStats
  attr_reader :game_manager, :team_manager, :game_teams_manager

  def initialize(game_path, team_path, game_teams_path)
    @game_manager = GameManager.new(game_path, self)
    @team_manager = TeamManager.new(team_path, self)
    @game_teams_manager = GameTeamsManager.new(game_teams_path, self)
  end

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    new(game_path, team_path, game_teams_path)
  end

  # ----------SeasonStats

  def winningest_coach(season)
    @game_teams_manager.winningest_coach(season)
  end

  def find_game_ids_for_season(season)
    @game_manager.find_game_ids_for_season(season)
  end

  # ----------LeaugeStats
  def count_of_teams
    total_number_of_teams
  end

  def best_offense
    calculate_best_offense
  end

  def worst_offense
    calculate_worst_offense
  end

  def highest_scoring_visitor
    calculate_highest_scoring_visitor
  end

  def highest_scoring_home_team
    calculate_highest_scoring_home_team
  end

  def lowest_scoring_visitor
    calculate_lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    calculate_lowest_scoring_home_team
  end

  def create_team_stats_hash
    team_manager.create_team_stats_hash
  end
end
