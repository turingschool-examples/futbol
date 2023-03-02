require 'csv'
require_relative 'classes'
require_relative 'game_stats'
require_relative 'season_stats'
require_relative 'league_stats'

class StatTracker
  attr_reader :game_stats,
              :league_stats,
              :season_stats

  def self.from_csv(locations)
    new(locations)
  end

  def initialize(locations)
    @game_stats = GameStats.new(locations)
    @league_stats = LeagueStats.new(locations)
    @season_stats = SeasonStats.new(locations)
  end
end