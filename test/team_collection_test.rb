require './test/test_helper'
require './lib/team_collection'

class TeamsCollectionTest < Minitest::Test

  def setup
    @total_teams = TeamCollection.new("./test/data/teams_sample.csv", "./test/data/game_teams_sample.csv")
  end

  def test_it_exists
    assert_instance_of TeamCollection, @total_teams
  end

  def test_it_has_total_teams
    @total_teams.create_teams("./test/data/teams_sample.csv")
    assert_equal 8, @total_teams.total_teams.length
  end

  def test_it_has_winningest_team
    # FC Dallas has only wins
    assert_equal "FC Dallas", @total_teams.winningest_team
  end

  def test_it_has_the_best_offense
    assert_equal "New York City FC", @total_teams.best_offense
  end

  def test_it_has_best_fans
    assert_equal "New England Revolution", @total_teams.best_fans
  end

  def test_it_has_worst_fans
    assert_equal [], @total_teams.worst_fans
  end
end
