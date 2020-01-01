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
require_relative 'team_season'
require_relative 'team_season_collection'

class Tracker
  attr_reader :game_collection,
              :team_collection,
              :team_season_collection,
              :season_collection,
              :game_teams_collection

  def self.from_csv(locations)
    games = locations[:games]
    teams = locations[:teams]
    game_teams = locations[:game_teams]

    StatTracker.new(games, teams, game_teams)
  end

  def initialize(games, teams, game_teams)
    @game_collection = GameCollection.new(games)
    @team_collection = TeamCollection.new(teams)
    @season_collection = SeasonCollection.new(games)
    @team_season_collection = TeamSeasonCollection.new(games)
    @game_teams_collection = GameTeamsCollection.new(game_teams)
  end
end
