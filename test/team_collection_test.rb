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
    assert_equal 8, @total_teams.total_teams.length
  end

  def test_it_has_count_of_teams
    assert_equal 8, @total_teams.count_of_teams
  end

  def test_it_has_the_best_offense
    assert_equal "New York City FC", @total_teams.best_offense
  end

  def test_it_has_the_worst_offense
    assert_equal "Sporting Kansas City", @total_teams.worst_offense
  end

  def test_it_has_the_best_defense
    assert_equal "FC Dallas", @total_teams.best_defense
  end

  def test_it_has_the_worst_defense
    assert_equal "Houston Dynamo", @total_teams.worst_defense
  end

  def test_it_has_winningest_team
    # FC Dallas has only wins
    assert_equal "FC Dallas", @total_teams.winningest_team
  end

  def test_it_has_best_fans
    assert_equal "LA Galaxy", @total_teams.best_fans
  end

  def test_it_has_worst_fans
    # with data samples as of 10/25/19,
    # there are no worst fans in the data set
    #need to include more data so we an actually get a list of the worst teams?
    assert_equal [], @total_teams.worst_fans
  end

  def test_it_can_find_highest_away_average
    assert_equal "FC Dallas", @total_teams.highest_scoring_visitor
  end

  def test_it_can_find_highest_home_average
    assert_equal "New York City FC", @total_teams.highest_scoring_home_team
  end

  def test_it_can_find_the_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @total_teams.lowest_scoring_visitor
  end

  def test_it_can_find_the_lowest_scoring_home_team
    assert_equal "Sporting Kansas City", @total_teams.lowest_scoring_home_team
  end
end
