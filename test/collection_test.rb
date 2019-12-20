require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require './lib/collection'
require './lib/game'
require './lib/team'
require './lib/game_team'

class CollectionTest < Minitest::Test
  def setup
    @games = './test/fixtures/games_truncated.csv'
    @teams = './test/fixtures/teams_truncated.csv'
    @game_teams = './test/fixtures/game_teams_truncated.csv'
  end

  def test_collection_exists
    collection1 = Collection.new(@games, Game)

    assert_instance_of Collection, collection1
  end

  def test_collection_attributes_game
    collection1 = Collection.new(@games, Game)
    games = collection1.collection

    assert_equal '17', games['2012030233'].home_team_id
  end

  def test_collection_attributes_team
    collection1 = Collection.new(@teams, Team)
    teams = collection1.collection

    assert_equal 'DC', teams['14'].abbreviation
  end
end
