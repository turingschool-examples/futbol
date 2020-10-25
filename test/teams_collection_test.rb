require_relative './test_helper'
require './lib/teams_collection'
require 'CSV'

class TeamsCollectionTest < Minitest::Test

  def setup
    @teamscollection = TeamsCollection.new('./data/teams.csv')
  end

  def test_it_exists

    assert_instance_of TeamsCollection, @teamscollection
  end

  def test_first_game

    assert_instance_of Team, @teamscollection.teams[0]
  end

  def test_all_games

    assert_equal 32, @teamscollection.teams.length
  end
end
