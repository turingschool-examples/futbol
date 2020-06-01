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
    # @game_path = './data/games.csv'
    @team_path = './data/fixtures/team_fixture.csv'
    # @team_path = './data/teams.csv'
    @game_teams_path = './data/fixtures/game_teams_fixture.csv'
    # @game_teams_path = './data/game_teams.csv'

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

  #################### START SEASON STATISTIC TESTS #########################

  def test_it_can_select_games_based_on_season
    assert_equal 1, @stat_tracker.games_by_season("20162017").count
    assert_equal 2, @stat_tracker.games_by_season("20122013").count
    assert_equal 3, @stat_tracker.games_by_season("20132014").count
    assert_equal Array, @stat_tracker.games_by_season("20162017").class
    assert_equal Game, @stat_tracker.games_by_season("20162017").first.class
  end

  def test_it_can_group_season_games_by_team_id
    assert_equal 1, @stat_tracker.season_games_grouped_by_team_id("20162017").count
    assert_equal 3, @stat_tracker.season_games_grouped_by_team_id("20132014").count
    assert_equal Game, @stat_tracker.season_games_grouped_by_team_id("20122013").values[0][0].class
    assert_equal "2016030235", @stat_tracker.season_games_grouped_by_team_id("20162017").keys[0]
  end

  def test_it_can_select_game_teams_by_season
    assert_equal 2, @stat_tracker.game_teams_by_season("20162017").count
    assert_equal 6, @stat_tracker.game_teams_by_season("20132014").count
    assert_equal GameTeam, @stat_tracker.game_teams_by_season("20162017")[0].class
  end

  def test_it_can_get_highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_it_can_get_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_determine_the_winningest_coach
    expected1 = ["Darryl Sutter", "Ralph Krueger"]
    assert_includes expected1, @stat_tracker.winningest_coach("20122013")
    expected2 = ["Ken Hitchcock", "Alain Vigneault"]
    assert_includes expected2, @stat_tracker.winningest_coach("20142015")
    assert_equal "Mike Yeo", @stat_tracker.winningest_coach("20162017")
  end

  def test_it_can_determine_the_worst_coach
    expected = ["Patrick Roy", "Bruce Boudreau", "Ken Hitchcock"]
    assert_includes expected, @stat_tracker.worst_coach("20122013")
    assert_equal "Mike Yeo", @stat_tracker.worst_coach("20142015")
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20162017")
  end

  def test_it_can_count_up_goals_for_teams_over_a_season
    skip
    assert_equal 4, @stat_tracker.total_season_goals_grouped_by_team("20122013")["22"]
    assert_equal ["19", "26", "22", "30"], @stat_tracker.total_season_goals_grouped_by_team("20122013").keys
    assert_equal [0,1,4,1], @stat_tracker.total_season_goals_grouped_by_team("20122013").values
  end

  def test_it_can_count_up_shots_for_teams_over_a_season
    skip
    assert_equal 9, @stat_tracker.total_season_shots_grouped_by_team("20122013")["30"]
    assert_equal ["19", "26", "22", "30"], @stat_tracker.total_season_shots_grouped_by_team("20122013").keys
    assert_equal [7,5,4,9], @stat_tracker.total_season_shots_grouped_by_team("20122013").values
  end

  def test_it_can_get_the_ratio_of_shots_to_goals_for_the_season
    skip
    assert_equal 0.2, @stat_tracker.season_ratio_goals_to_shots_grouped_by_team("20122013")["26"]
    assert_equal 1.0, @stat_tracker.season_ratio_goals_to_shots_grouped_by_team("20122013")["22"]
    assert_equal ["19", "26", "22", "30"], @stat_tracker.season_ratio_goals_to_shots_grouped_by_team("20122013").keys
  end

  def test_it_can_determine_the_most_accurate_team
    assert_equal "Washington Spirit FC", @stat_tracker.most_accurate_team("20122013")
    assert_equal "Houston Dynamo", @stat_tracker.most_accurate_team("20142015")
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

  def test_it_can_count_up_tackles_for_a_team_for_the_season
    assert_equal 53, @stat_tracker.total_season_tackles_grouped_by_team("20122013")["26"]
    assert_equal ["19", "26", "22", "30"], @stat_tracker.total_season_tackles_grouped_by_team("20122013").keys
    assert_equal [39, 53, 15, 25], @stat_tracker.total_season_tackles_grouped_by_team("20122013").values
  end

  def test_it_can_determine_the_team_with_the_most_tackles
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20122013")
    assert_equal "Orlando City SC", @stat_tracker.most_tackles("20142015")
    assert_equal "Philadelphia Union", @stat_tracker.most_tackles("20162017")
  end

  def test_it_can_determine_the_team_with_the_fewest_tackles
    assert_equal "Washington Spirit FC", @stat_tracker.fewest_tackles("20122013")
    assert_equal "DC United", @stat_tracker.fewest_tackles("20142015")
    assert_equal "Minnesota United FC", @stat_tracker.fewest_tackles("20162017")
  end

  def test_creates_collections_once
    collection1 = @stat_tracker.game_team_collection_to_use
    collection2 = @stat_tracker.game_team_collection_to_use
    assert_equal true, collection1 == collection2
    assert_equal Array, @stat_tracker.game_collection_to_use.class
    assert_equal Array, @stat_tracker.team_collection_to_use.class
    assert_equal Array, @stat_tracker.game_team_collection_to_use.class
  end
  ########################## END SEASON STATISTICS #############################
end
