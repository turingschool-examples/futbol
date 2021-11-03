
require 'CSV'

class StatTracker
  def self.from_csv(locations)
    StatTracker.new
  end

  def initialize(locations)
    @games = GameManager.new(locations[:games])
    @teams = TeamManager.new(locations[:teams])
    @game_teams = GamesTeamsManager.new(locations[:game_teams])
  end

  def highest_total_score
    @games.highest_total_score
  end

  def some_other_method
    @teams.some_other_method
  end
end
