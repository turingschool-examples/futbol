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

  #what happened to testing it can be made from csv?

  def test_it_has_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_it_has_biggest_blowout
    assert_equal 2, @stat_tracker.biggest_blowout
  end

  def test_it_has_percentage_home_wins
    assert_equal 0.25, @stat_tracker.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 0.50, @stat_tracker.percentage_visitor_wins
  end

  def test_it_has_percentage_ties

  end
end
