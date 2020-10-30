require 'csv'

class StatTracker
  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  attr_reader :argument

  def initialize(locations)
    @load_files(locations)
  end

  def load_files(locations)
    @games = Game.new(locations[:games], self)
    @teams = Team.new(locations[:teams], self)
    @game_teams = GameTeam.new(locations[:game_teams], self)
  end
end
