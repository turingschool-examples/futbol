require 'CSV'
require 'pry'
require_relative 'game_manager'
require_relative 'team_manager'
require_relative 'game_team_manager'

class StatTracker
  attr_reader :game_manager,
              :team_manager,
              :game_team_manager

  def initialize(file_paths)
    @game_manager      = GameManager.new(file_paths[:games])
    @team_manager      = TeamManager.new(file_paths[:teams])
    @game_team_manager = GameTeamManager.new(file_paths[:game_teams])
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
end






# games = CSV.read(file_paths[:games], headers: true, header_converters: :symbol)
# teams = CSV.read(file_paths[:teams], headers: true, header_converters: :symbol)
# game_teams = CSV.read(file_paths[:game_teams], headers: true, header_converters: :symbol)
# StatTracker.new(games, teams, game_teams)
