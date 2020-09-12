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

  def test_it_can_count_total_of_team_wins_by_season
    expected = {
      "1" => {
        "20122013" => 2,
        "20132014" => 2,
        "20142014" => 2,
        "20152016" => 1,
        "20162017" => 1,
        "20172018" => 1
      },
      "4" => {
        "20122013" => 1,
        "20132014" => 2,
        "20142015" => 3,
        "20152016" => 1,
        "20162017" => 0,
        "20172018" => 0
      },
      "6" => {
        "20122013" => 1,
        "20132014" => 2,
        "20142015" => 4,
        "20152016" => 2,
        "20162017" => 1,
        "20172018" => 2
      },
      "14" => {
        "20122013" => 0.0,
        "20132014" => 25.0,
        "20142015" => 0.0,
        "20152016" => 100.0,
        "20162017" => 60.0,
        "20172018" => 60.0
      },
      "26" => {
        "20122013" => 0,
        "20132014" => 2,
        "20142015" => 3,
        "20152016" => 0,
        "20162017" => 1,
        "20172018" => 3
      }
    }
    assert_equal expected, @game_teams_manager.total_team_wins_by_season
  end

end
