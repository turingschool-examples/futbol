require 'csv'
# require_relative './helper_class'

class StatTracker
  def self.from_csv(locations)
    @games_manager = GamesManager.new(locations[:games], self)
    @teams_manager = TeamsManager.new(locations[:teams], self)
    @game_teams_manager = GameTeamsManager.new(locations[:game_teams], self)
    StatTracker.new
  end
end
