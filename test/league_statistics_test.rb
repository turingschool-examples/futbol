require_relative 'test_helper'

class LeagueStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    @stat_tracker ||= StatTracker.from_csv({games: game_path})
    @stat_tracker ||= StatTracker.from_csv({teams: game_path})
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

end
