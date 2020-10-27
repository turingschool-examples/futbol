require 'csv'
require_relative './game_manager'
require_relative './team_manager'
require_relative './game_teams_manager'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(file_locations)
    @games = file_locations[:games]
    @teams = file_locations[:teams]
    @game_teams = file_locations[:game_teams]
    @game_manager = GameManager.new(@games)
  end

  def self.from_csv(file_locations)
    StatTracker.new(file_locations)
  end

  # def game_manager
  #   @game_manager ||= GameManager.new(@games)
  # end
  #
  # def highest_total_score
  #   @game_manager.all
  #   @game_manager.highest_total_score
  # end
end
