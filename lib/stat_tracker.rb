require './lib/game_loader'
require './lib/team_loader'
require './lib/game_team_loader'

class StatTracker
  attr_reader :game_loader,
              :team_loader,
              :game_team_loader

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    load_files(locations)
  end

  def load_files(locations)
    @game_loader = GameLoader.new(locations[:games], self)
    @team_loader = TeamLoader.new(locations[:teams], self)
    @game_team_loader = GameTeamLoader.new(locations[:game_teams], self)
  end
end
