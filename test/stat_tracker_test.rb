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

  def test_it_can_get_team_info
    skip
    expected = {
                :team_id => "30",
                :franchise_id => "37",
                :team_name => "Orlando City SC",
                :abbreviation => "ORL",
                :link => "/api/v1/teams/30"
                }
    assert_equal expected, @stat_tracker.team_info("30")
  end

  def test_it_can_filter_home_games_by_team
    assert_equal 2, @stat_tracker.home_games_filtered_by_team("19").count
  end

  def test_it_can_filter_away_games_by_team
    assert_equal 2, @stat_tracker.away_games_filtered_by_team("19").count
  end

  def test_it_can_group_home_games_by_season
    assert_equal true, @stat_tracker.home_games_grouped_by_season("19").keys.include?("20142015")
    assert_equal true,
    @stat_tracker.home_games_grouped_by_season("19").keys.include?("20162017")
    assert_equal false, @stat_tracker.home_games_grouped_by_season("19").keys.include?(:tie)
  end

  def test_it_can_group_away_games_by_season
    assert_equal true, @stat_tracker.away_games_grouped_by_season("19").keys.include?("20142015")
    assert_equal true,
    @stat_tracker.away_games_grouped_by_season("19").keys.include?("20122013")
    assert_equal false, @stat_tracker.away_games_grouped_by_season("19").keys.include?(:home_win)
  end

  def test_it_can_get_number_of_home_wins_in_season
    assert_equal true, @stat_tracker.season_home_wins("19").values.include?(-0.5)
  end

  def test_it_can_get_number_of_away_wins_in_season
    assert_equal true, @stat_tracker.season_away_wins("19").values.include?(-1.0)
    assert_equal true, @stat_tracker.season_away_wins("19").values.include?(1.0)
  end

  def test_it_can_get_total_wins_in_a_season
    assert_equal true, @stat_tracker.win_count_by_season("19").values.include?(1.0)
  end

  def test_it_can_get_best_season
    assert_equal "20162017", @stat_tracker.best_season("19")
  end

  def test_it_can_get_worst_season
    skip
    assert_equal "20142015", @stat_tracker.worst_season("19")
  end

end
