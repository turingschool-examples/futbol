require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_collection'
require './lib/game'
require './lib/team_collection'
require './lib/team'
require './lib/game_team_collection'
require './lib/game_team'

class StatTrackerTest < Minitest::Test
  def setup ## instantiate using the from_csv
    @game_path = './data/fixtures/game_fixture.csv'
    @team_path = './data/fixtures/team_fixture.csv'
    @game_teams_path = './data/fixtures/game_teams_fixture.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal './data/fixtures/game_fixture.csv', @stat_tracker.games
    assert_equal './data/fixtures/team_fixture.csv', @stat_tracker.teams
    assert_equal './data/fixtures/game_teams_fixture.csv', @stat_tracker.game_teams
  end

  def test_it_can_have_game_collection
    assert_instance_of GameCollection, @stat_tracker.game_collection
  end

  def test_it_can_have_team_collection
    assert_instance_of TeamCollection, @stat_tracker.team_collection
  end

  def test_it_can_have_game_team_collection
    assert_instance_of GameTeamCollection, @stat_tracker.game_team_collection
  end

  def test_it_can_get_highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_it_can_get_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_determine_the_winningest_coach
    # @stat_tracker.worst_coach("20132014")
    expected = ["Darryl Sutter", "Ralph Krueger"]
    assert_includes expected, @stat_tracker.winningest_coach("20122013")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
    assert_equal "Mike Yeo", @stat_tracker.winningest_coach("20162017")
  end

  def test_it_can_determine_the_worst_coach
    expected = ["Patrick Roy", "Bruce Boudreau", "Ken Hitchcock"]
    assert_includes expected, @stat_tracker.worst_coach("20122013")
    assert_equal "Jon Cooper", @stat_tracker.worst_coach("20142015")
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20162017")
  end

  def test_it_can_determine_the_most_accurate_team
    assert_equal "Washington Spirit FC", @stat_tracker.most_accurate_team("20122013")
    assert_equal "Houston Dynamo", @stat_tracker.most_accurate_team("20142015")
    assert_equal "Philadelphia Union", @stat_tracker.most_accurate_team("20152016")
  end

  def test_it_can_determine_the_least_accurate_team
    assert_equal "Philadelphia Union", @stat_tracker.least_accurate_team("20122013")
    assert_equal "Orlando City SC", @stat_tracker.least_accurate_team("20142015")
    assert_equal "Minnesota United FC", @stat_tracker.least_accurate_team("20162017")
  end

  def test_it_can_return_team_name_based_off_of_team_id
    assert_equal "Philadelphia Union", @stat_tracker.team_name_based_off_of_team_id("19")
    assert_nil nil, @stat_tracker.team_name_based_off_of_team_id("5")
  end

  def test_it_can_determine_the_team_with_the_most_tackles
    assert_equal "Orlando City SC", @stat_tracker.most_tackles("20122013")
    assert_equal "Orlando City SC", @stat_tracker.most_tackles("20142015")
    assert_equal "Philadelphia Union", @stat_tracker.most_tackles("20162017")
  end

  def test_it_can_determine_the_team_with_the_fewest_tackles
    assert_equal "Washington Spirit FC", @stat_tracker.fewest_tackles("20122013")
    assert_equal "DC United", @stat_tracker.fewest_tackles("20142015")
    assert_equal "Minnesota United FC", @stat_tracker.fewest_tackles("20162017")
  end

end
