require_relative './game_collection'
require_relative './team_collection'
require_relative './game_teams_collection'

class StatisticsLibray
  def initialize(info)
    @games = GameCollection.all(info[:games])
    @teams = TeamCollection.all(info[:teams])
    @game_teams = GameTeamsCollection.all(info[:game_teams])
  end
end
