require "csv"
require_relative "./teams_collection"
require_relative "./games_collection"
require_relative "./game_teams_collection"
# require_relative "./game_statistics"
require_relative "./league_statistics"
# require_relative "./season_statistics"
# require_relative "./team_statistics"


class StatTracker

  # include GameStatistics
  include LeagueStatistics
  # include SeasonStatistics
  # include TeamStatistics

  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games ||= collect_games(locations[:games])
    @teams ||= collect_teams(locations[:teams])
    @game_teams ||= collect_game_teams(locations[:game_teams])
  end

  def self.from_csv(locations)
    self.new(locations)
  end

  def collect_game_teams(location)
    game_teams = GameTeamsCollection.new(location)
    game_teams.load_csv
    game_teams.collection
  end

  def collect_teams(location)
    teams = TeamsCollection.new(location)
    teams.load_csv
    teams.collection
  end

  def collect_games(location)
    games = GamesCollection.new(location)
    games.load_csv
    games.collection
  end

end
