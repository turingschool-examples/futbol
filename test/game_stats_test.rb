# require './test/test_helper'
# require './lib/game_stats'
# require './lib/team_collection'
# require './lib/game_collection'
# require './lib/game_team_collection'
#
#
# class GameStatsTest < Minitest::Test
#
#   def setup
#     @team_collection = TeamCollection.new('./data/teams.csv')
#     @game_collection = GameCollection.new('./data/games_fixture.csv')
#     @game_team_collection = GameTeamCollection.new('./data/game_teams_fixture.csv')
#     @season_stats = SeasonStats.new(@game_collection, @game_team_collection, @team_collection)
#   end
#
#   def test_it_has_highest_total_score
#     assert_equal 7, @game_stats.highest_total_score
#   end
# end
