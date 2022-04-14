require 'csv'
require './modules/game_statistics'
require './modules/league_statistics'


class StatTracker
  include GameStats
  include LeagueStats
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = CSV.read(locations[:games], headers: true)
    @teams = CSV.read(locations[:teams], headers: true)
    @game_teams = CSV.read(locations[:game_teams], headers: true)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
