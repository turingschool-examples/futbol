
require "csv"
require "./lib/game_collection"
require "./lib/team_collection"
require "./lib/game_team_collection"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @games.all
  end

  def teams
    @teams.all
  end

  def game_teams
    @game_teams.all
  end

  def all_games_per_season(season_id)
    games.select do |game|
      game.season.eql?(season_id)
    end
  end
end
