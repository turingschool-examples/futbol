require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def self.from_csv(locations)
    games = locations[:games]
    teams = locations[:teams]
    game_teams = locations[:game_teams]

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end
end
