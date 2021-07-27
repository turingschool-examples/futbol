require './lib/games'
require './lib/teams'
require './lib/game_teams'

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(files)
    # game_stats = GameStats.new(files)
    @games ||= Games.file(files[:games])
    require 'pry'; binding.pry
    # @teams ||= Teams.file(files[:teams])
    # @game_teams ||= GameTeams.file(files[:game_teams])
  end

  def self.from_csv(files)
    new(files)
  end
end
