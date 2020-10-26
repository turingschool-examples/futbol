require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_statistics'

class GameStatsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    dummy_path = './data/dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
      dummy: dummy_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    @dummy_stats = stat_tracker.all_data[:dummy]
    @game = GameStats.new(@dummy_stats)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameStats, @game
    assert_equal @dummy_stats, @game.stats
  end

  def test_it_can_convert_to_integers
    assert_equal [1, 2], @game.convert_to_i(["1", "2"])
  end

  def test_it_can_sum_data
    skip
    goals_sum = 19

    assert_equal goals_sum, @game.sum_data(:goals)
  end

  def test_it_can_extract_data_values
    expected = ["2", "3", "2", "3", "2", "1", "3", "2", "1"]
    assert_equal expected, @game.iterator(:goals)
  end

  # def test_it_can_select_stats_by_header
  #   team_id = "3"
  #   team_3_goal_sum = 8
  #   team_3_stats = @game.team_stats(:team_id, team_id)
  #
  #   assert_instance_of CSV::Table, team_3_stats
  #   assert_equal team_3_goal_sum, @game.sum_data(:goals, team_3_stats)
  # end

  def test_highest_total_score

  end
end
