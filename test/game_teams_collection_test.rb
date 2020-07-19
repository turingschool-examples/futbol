require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams_collection'
#require './lib/game_team'
require 'csv'

class GameTeamsCollectionTest < Minitest::Test
  def test_it_exists
    gtc = GameTeamsCollection.new('./test/fixtures/game_teams.csv')
    assert_instance_of GameTeamsCollection, gtc
  end
  def test_has_a_path
    gtc = GameTeamsCollection.new('./test/fixtures/game_teams.csv')
    assert_equal './test/fixtures/game_teams.csv', gtc.path
  end
end
