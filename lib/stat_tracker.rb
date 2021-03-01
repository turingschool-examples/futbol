require 'CSV'
require_relative './game_manager'
require_relative './team_manager'
require_relative './game_team_manager'
require_relative './csv_parser'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

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
    @team_manager = load_it_up(locations[:teams], Team)
    @game_team_manager = load_it_up(locations[:game_teams], GameTeam)
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
end
