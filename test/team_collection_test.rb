require './test/test_helper'
require 'csv'
require './lib/team'
require './lib/stat_tracker'
require './lib/team_collection'
require './lib/game_collection'
require './lib/game'

class TeamCollectionTest < MiniTest::Test

  def setup
    @team_instance = TeamCollection.new('./dummy_data/dummy_teams.csv')
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_instance
  end

  def test_the_count_of_teams
    assert_equal 16, @team_instance.count_of_teams
  end

  def test_winningest_team_method
    assert_equal "FC Dallas", @team_instance.winningest_team("6")
    assert_equal "LA Galaxy", @team_instance.winningest_team("17")
  end

  def test_highest_scoring_visitor
    game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    assert_equal "FC Dallas", @team_instance.highest_scoring_visitor(game_collection.highest_visitor_id)
  end

  def test_highest_scoring_home_team
    game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    assert_equal "DC United", @team_instance.highest_scoring_home_team(game_collection.highest_home_id)
  end

  def test_lowest_scoring_visitor
    game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    assert_equal "Toronto FC", @team_instance.lowest_scoring_visitor(game_collection.lowest_visitor_id)
  end

  def test_lowest_scoring_home_team
    game_collection = GameCollection.new('./dummy_data/dummy_games.csv')
    assert_equal "Sporting Kansas City", @team_instance.lowest_scoring_home_team(game_collection.lowest_home_id)
  end
end
