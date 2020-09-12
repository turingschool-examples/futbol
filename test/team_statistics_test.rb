require_relative 'test_helper'

class TeamStatisticsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    @stat_tracker ||= StatTracker.new({games: game_path, teams: team_path})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_team_info
    expected = {    "team_id" => "18",
                    "franchise_id" => "34",
                    "team_name" => "Minnesota United FC",
                    "abbreviation" => "MIN",
                    "link" => "/api/v1/teams/18"
                  }
    assert_equal expected, @stat_tracker.team_info("18")
    @stat_tracker.collect_seasons("1")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    skip
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_average_win_percentage
    assert_equal  0.49, @stat_tracker.average_win_percentage("6")
  end
end
