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
    GameTeamsCollection.from_csv('./test/fixtures/game_teams.csv')
    assert_equal GameTeamsCollection.all_game_teams.length, 240
    assert_equal GameTeamsCollection.all_game_teams[0].class, GameTeam
  end

  def test_game_teams_empty
    assert_equal [], GameTeamsCollection.all_game_teams
  end

  def test_add_game_teams
    GameTeamsCollection.add_game_team({})

    assert_equal GameTeamsCollection.all_game_teams.length, 1
  end

# from_csv
# Input: game_team data file path
# Output: Array of game_team objects
# This method should call read_data and then instantiate_game_teams
end
