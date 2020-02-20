require 'csv'
require './lib/game_teams'
require './lib/game_teams_collection'
require 'minitest/autorun'
require 'minitest/pride'

class GameTeamsCollectionTest < Minitest::Test

  def setup
    @locations = './data/little_game_teams.csv'
    @gtc = GameTeamsCollection.new(@locations)
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @gtc
  end

  def test_it_can_create_an_array_of_game_data_objects
    assert_instance_of Array, @gtc.game_teams
    assert_instance_of GameTeams, @gtc.game_teams.first
  end

  def test_it_has_as_many_teams_as_data_lines
    assert = @gtc.game_teams.length == CSV.readlines(@locations, headers: true).size
  end

  def test_it_has_real_data
    assert_equal "LOSS", @gtc.game_teams.first.result
    assert_equal "John Tortorella", @gtc.game_teams.first.head_coach
  end
end
