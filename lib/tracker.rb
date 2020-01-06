require 'csv'
require_relative 'game'
require_relative 'team'
require_relative 'game_teams'
require_relative 'season'
require_relative 'collection'
require_relative 'game_collection'
require_relative 'team_collection'
require_relative 'game_teams_collection'
require_relative 'season_collection'
require_relative './modules/calculateable'

class Tracker
  include Calculateable

  attr_reader :games,
              :teams,
              :seasons,
              :game_teams

  def self.from_csv(locations)
    games = locations[:games]
    teams = locations[:teams]
    game_teams = locations[:game_teams]

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @games = GameCollection.new(games)
    @game_teams = GameTeamsCollection.new(game_teams)
    @teams = TeamCollection.new(teams)
    combine_game_data
    @seasons = SeasonCollection.new(games)
    # combine_season_data
  end
end
