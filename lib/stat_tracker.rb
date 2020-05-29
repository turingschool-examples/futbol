
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
  ###################
  ## SEASON METHODS##
  ###################

  def all_games_per_season(season_id)
    games.select do |game|
      game.season.eql?(season_id)
    end
  end

  def all_game_teams_per_season(season_id)
    game_teams.select do |game_team|
      all_games_per_season(season_id).any?{|game| game.game_id.eql?game_team.game_id}
    end
  end

  def games_by_head_coach(season_id)
    all_game_teams_per_season(season_id).group_by do |game_team|
      game_team.head_coach
    end
  end
end
