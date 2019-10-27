require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/team_collection'

class TeamsCollectionTest < Minitest::Test
  def setup
    # @total_teams = TeamCollection.new("./test/data/teams_sample.csv", "./test/data/game_teams_sample.csv")
    @total_teams = TeamCollection.new("./test/data/teams_sample.csv", "./test/data/game_teams_sample.csv")
  end

  def test_it_exists
    assert_instance_of TeamCollection, @total_teams
  end

  def test_it_has_total_teams
    @total_teams.create_teams("./test/data/teams_sample.csv")
    assert_equal 3, @total_teams.total_teams.length
  end

  def test_it_has_count_of_teams
    assert_equal 3, @total_teams.count_of_teams
  end

  def test_it_has_the_best_offense
    assert_equal "FC Cincinnati", @total_teams.best_offense
  end

  def test_it_has_the_worst_offense
    assert_equal "Atlanta United", @total_teams.worst_offense
  end

  def test_it_has_the_best_defense
    assert_equal "Atlanta United", @total_teams.best_defense
  end

  def test_it_has_the_worst_defense
    assert_equal "Chicago Fire", @total_teams.worst_defense
  end

  def test_it_has_winningest_team
    assert_equal "Atlanta United", @total_teams.winningest_team
  end

  def test_it_has_best_fans
    assert_equal "FC Cincinnati", @total_teams.best_fans
  end

  def test_it_has_worst_fans
    assert_equal ["Chicago Fire"], @total_teams.worst_fans
  end

  def test_it_can_find_highest_away_average
    assert_equal "Chicago Fire", @total_teams.highest_scoring_visitor
  end

  def test_it_can_find_highest_home_average
    assert_equal "FC Cincinnati", @total_teams.highest_scoring_home_team
  end

  def test_it_can_find_the_lowest_scoring_visitor
    assert_equal "FC Cincinnati", @total_teams.lowest_scoring_visitor
  end

  def test_it_can_find_the_lowest_scoring_home_team
    assert_equal "Chicago Fire", @total_teams.lowest_scoring_home_team
  end
end
