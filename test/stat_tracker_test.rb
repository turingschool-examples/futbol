require "./test/test_helper"
require "./lib/stat_tracker"

class StatTrackerTest < Minitest::Test
  def setup
    @team_path = './data/teams_sample.csv'
    @game_path = './data/games_sample.csv'
    @game_teams_path = './data/game_teams_sample.csv'
  end

  def test_it_is_a_stat_tracker
    stats = StatTracker.new(@team_path, @game_path, @game_teams_path)

    assert_instance_of StatTracker, stats
  end
end
