require './spec/spec_helper'

class TeamSeason
  attr_accessor :goals,
                :games,
                :shots,
                :tackles,
                :home_games,
                :away_games
  def initialize(season, team_id)
    @team_id = team_id
    @season = season
    @goals = 0
    @games = 0
    @shots = 0
    @tackles = 0
    @home_games = 0
    @away_games = 0
  end
end
# hash = {}
# stat_tracker.game_teams do |game_team|
#   hash[game_team[:game_id]] = (
#   stat_stracker.game.find_all do |one_game|
#     one_game[:game_id] == one_game[:game_id]
#   end )
# end
