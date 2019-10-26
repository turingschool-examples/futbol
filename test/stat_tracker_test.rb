require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_collection'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/data/games_sample.csv'
    team_path = './test/data/teams_sample.csv'
    game_teams_path = './test/data/game_teams_sample.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    stat_tracker = StatTracker.new('./test/data/games_sample.csv', './test/data/teams_sample.csv', './test/data/game_teams_sample.csv')
    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_has_scores
    @stat_tracker.highest_total_score
  end

  def test_it_has_winningest_team
    # FC Dallas has only wins
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_it_has_the_best_offense
    assert_equal "New York City FC", @stat_tracker.best_offense
  end

  def test_it_has_best_fans
    assert_equal "LA Galaxy", @stat_tracker.best_fans
  end

  def test_it_has_worst_fans
    assert_equal [], @stat_tracker.worst_fans
  end
end
