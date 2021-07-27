require './lib/games'
require './lib/teams'
require './lib/game_teams'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(files)
    # game_stats = GameStats.new
    @games ||= Games.file(files[:games])
    @teams ||= Teams.file(files[:teams])
    @game_teams ||= GameTeams.file(files[:game_teams])
  end

  def self.from_csv(files)
    new(files)
  end
end
