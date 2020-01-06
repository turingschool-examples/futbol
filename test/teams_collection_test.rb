require_relative 'testhelper'
require_relative '../lib/stat_tracker'

class TeamsCollectionTest < Minitest::Test
  
  def setup
    @stat_tracker = StatTracker.new("./test/fixtures/games_trunc.csv", "./test/fixtures/teams_trunc.csv", "./test/fixtures/game_teams_trunc.csv")
    @teams_collection = TeamsCollection.new(@stat_tracker.teams_path)
  end

  def test_it_exists
    assert_instance_of TeamsCollection, @teams_collection
    assert_equal Array, @teams_collection.teams.class
  end

  def test_it_creates_game_teams
    assert_instance_of Team, @teams_collection.teams.first
    assert_equal 1, @teams_collection.teams.first.team_id
    assert_equal "ATL", @teams_collection.teams.first.abbreviation
  end

  def test_count_of_teams
    assert_equal 32, @teams_collection.count_of_teams
  end

  def test_associate_team_id_with_team_name
    assert_equal "Atlanta United", @teams_collection.associate_team_id_with_team_name(1)
  end

  def test_associate_multi_team_id_with_team_name
    assert_equal ["Chicago Fire", "Montreal Impact"], @teams_collection.associate_multi_team_id_with_team_name([4, 23])
  end
end
