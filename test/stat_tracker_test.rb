require "./test/test_helper.rb"
require 'CSV'
# require './lib/game_manager'
# require './lib/team_manager'
# require './lib/game_teams_manager'
require './lib/stat_tracker'
class StatTrackerTest < MiniTest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_highest_scores
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_lowest_scores
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

end
