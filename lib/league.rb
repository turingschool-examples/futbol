require './lib/stat_tracker.rb'
class League < StatTracker
  attr_reader :teams
  def initialize(games, teams, game_teams)
    super(@teams)
    super(@games)
    super(@game_teams)
  end
end
