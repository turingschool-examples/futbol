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

  def test_name_finder_method
    assert_equal "Chicago Fire", @team_instance.name_finder("4")
    assert_equal "New York Red Bulls", @team_instance.name_finder("8")
  end

  def test_worst_fans
    assert_equal ["Sporting Kansas City"], @team_instance.worst_fans(["5"])
  end
end
