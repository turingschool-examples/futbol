require "./test/test_helper"
require "./lib/game_teams_manager"

class GameTeamsManagerTest < Minitest::Test
  def setup
    @stat_tracker = StatTracker.from_csv
    @game_teams_manager = @stat_tracker.game_teams_manager
  end

  def test_it_exists
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_it_can_create_a_table_of_games
    skip
    @game_teams_manager.game_teams.all? do |game|
      assert_instance_of GameTeam, game
    end
  end

  def test_it_can_organize_season_win_percentage_for_each_team
    expected = {
      "1" => 28.57,
      "4" => 42.86,
      "6" => 66.67,
      "14" => 0,
      "26" => 42.86
    }
    assert_equal expected, @game_teams_manager.all_teams_win_percentage("20142015")
  end

  def test_it_can_determine_winningest_team
    assert_equal "6", @game_teams_manager.winningest_team("20142015")
  end

  def test_it_can_determine_team_with_worst_winning_percentage
    assert_equal "14", @game_teams_manager.worst_team("20142015")
  end

  def test_it_can_list_winningest_coach_by_season
    assert_equal "Claude Julien", @game_teams_manager.winningest_coach("20142015")
  end

  def test_it_can_determine_the_worst_coach_by_season
    assert_equal "Jon Cooper", @game_teams_manager.worst_coach("20142015")
  end

end
