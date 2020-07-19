require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams_collection'
require './lib/game_team'
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

  def test_it_can_read
    gtc = GameTeamsCollection.new('./test/fixtures/game_teams.csv')
    gtc.from_csv('./test/fixtures/game_teams.csv')
    assert_equal 240, gtc.all_game_teams.length
    assert_equal GameTeam, gtc.all_game_teams[0].class
  end

  def test_game_teams_empty
    gtc = GameTeamsCollection.new('./test/fixtures/game_teams.csv')
    assert_equal [], gtc.all_game_teams
  end

  def test_add_game_teams
    gtc = GameTeamsCollection.new('./test/fixtures/game_teams.csv')
    gtc.add_game_team({})
    assert_equal 1, gtc.all_game_teams.length
  end
end
