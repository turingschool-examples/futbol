require './test/test_helper'
require 'csv'
require './lib/team'
require './lib/stat_tracker'
require './lib/team_collection'

class TeamCollectionTest < MiniTest::Test

  def setup
    @team_instance = TeamCollection.new('./dummy_data/dummy_teams.csv')
  end

  def test_it_exists
    assert_instance_of TeamCollection, @team_instance
  end

  def test_the_count_of_teams
    assert_equal 15, @team_instance.count_of_teams
  end

  def test_winningest_team_method
    assert_equal "FC Dallas", @team_instance.winningest_team("6")
    assert_equal "LA Galaxy", @team_instance.winningest_team("17")
  end

  def test_array_of_team_ids
    assert_equal ["1", "4", "26", "14", "6", "3", "5", "17", "28", "18", "23", "16", "9", "8", "30"], @team_instance.array_of_team_ids
    assert_equal 15, @team_instance.array_of_team_ids.length
  end

  def test_worst_defense
    assert_equal "Houston Dynamo", @team_instance.worst_defense
  end

  def test_best_defense
    assert_equal "DC United, Montreal Impact", @team_instance.best_defense
  end

end
