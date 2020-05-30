require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require_relative 'game_stats'
require_relative 'game_collection'
require_relative 'game_team_collection'
require_relative 'team_collection'
require_relative 'league_stats'

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
