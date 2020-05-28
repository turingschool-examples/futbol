require_relative './game'
require_relative './team'
require_relative './game_teams'
require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(info)
    @games = info[:games]
    @teams = info[:teams]
    @game_teams = info[:game_teams]
  end

  def self.from_csv(info)
    StatTracker.new(info)
  end

  # Game Statistic methods


  # League Statistic methods
  def count_of_teams
    teams = CSV.read(@teams, headers: true)
    teams.count
  end


  # Season Statistic methods


  # Team Statistic methods
end
