require "csv"
require "spec_helper"

class StatTracker
  attr_reader :game_stats,
              :league_stats
              :team_stats
  
  def self.from_csv(files)
    StatTracker.new
  end

  def initialize(files)
    @game_stats = GameStats.new(files)
    @league_stats = LeagueStats.new(files)
    @team_stats = SeasonStats.new(files)
  end
end