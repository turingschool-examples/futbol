require 'CSV'
require_relative './game_manager'
require_relative './team_manager'
require_relative './game_teams_manager'
require_relative './csv_parser'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'

require 'pry'

class StatTracker
  include CsvParser

  attr_reader :game_manager,
              :team_manager,
              :game_teams_manager

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @game = load_it_up(locations[:games], Game)
      #becomes an array of game objects
        # needs to be passed in game_manger as argument
    @team = load_it_up(locations[:teams], Team)
    @game_team = load_it_up([:game_teams], GameTeams)

  end

  def highest_total_score
    @game_manager.highest_total_score_in_game
  end

  def lowest_total_score
    @game_manager.game_with_lowest_total_score.total_goals
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
end
