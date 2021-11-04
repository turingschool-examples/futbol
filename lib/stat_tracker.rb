require 'CSV'
require './lib/game_teams'
require './lib/games'
require './lib/teams'
require './lib/game_teams_manager'
require './lib/game_manager'
require './lib/teams_manager'

class StatTracker
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games = GameManager.new(locations[:games])
    @teams = TeamManager.new(locations[:teams])
    @game_teams = GameTeamsManager.new(locations[:game_teams])
  end

  def highest_total_score
    @games.highest_total_score
  end

  def some_other_method
    @teams.some_other_method
  end
end
