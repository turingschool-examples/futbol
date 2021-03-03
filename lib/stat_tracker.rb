require 'CSV'
require_relative './game_manager'
require_relative './team_manager'
require_relative './game_team_manager'
require_relative './csv_parser'
# require_relative 'game'
# require_relative 'team'
# require_relative 'game_team'

require 'pry'

class StatTracker
  include CsvParser

  attr_reader :game_manager,
              :team_manager,
              :game_team_manager

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game_manager = GameManager.new(locations[:games])
      #becomes an array of game objects
        # needs to be passed in game_manger as argument
    @team_manager = TeamManager.new(locations[:teams])
    @game_team_manager = GameTeamManager.new(locations[:game_teams])
  end

  def highest_total_score
    @game_manager.highest_total_score
  end

  def lowest_total_score
    @game_manager.lowest_total_score
  end

  def percentage_home_wins
    @game_manager.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_manager.percentage_visitor_wins
  end

  def percentage_ties
    @game_manager.percentage_ties
  end

  def count_of_games_by_season
    @game_manager.count_of_games_by_season
  end

  def average_goals_per_game
    @game_manager.average_goals_per_game
  end

  def average_goals_by_season
    @game_manager.average_goals_by_season
  end

  def count_of_teams
    @team_manager.count_of_teams
  end

  def best_offense
    # require 'pry'; binding.pry
    team_best_average = @game_team_manager.teams_max_average_goals
    @team_manager.find_team_by_id(team_best_average).teamname
  end

  def worst_offense
    team_least_average = game_team_manager.teams_least_average_goals
    @team_manager.find_team_by_id(team_least_average).teamname
  end
end
