require './lib/teams_processor'
require './lib/games_processor'
require './lib/game_teams_processor'


class StatTracker
  include TeamsProcessor
  include GamesProcessor
  include GameTeamsProcessor

  attr_reader :games,
              :teams,
              :game_teams

  def initialize(locations)
    @games = parse_games_file(locations[:games])
    @teams = parse_teams_file(locations[:teams])
    @game_teams = parse_game_teams_file(locations[:game_teams])
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
end
