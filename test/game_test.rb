require_relative 'test_helper'

class GameTest < Minitest::Test

  def setup
    game_path = './data/games.csv'

    @stat_tracker ||= StatTracker.new({games: game_path})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    stat = StatTracker.new
    assert_equal false, stat.game_table.include?("2012030221")
    actual = @stat_tracker.game_table["2012030221"]

    assert_equal 2012030221, actual.game_id
    assert_equal "20122013", actual.season
    assert_equal "Postseason", actual.type
    assert_equal "5/16/13", actual.date_time
    assert_equal 3, actual.away_team_id
    assert_equal 6, actual.home_team_id
    assert_equal 2, actual.away_goals
    assert_equal 3, actual.home_goals
    assert_equal "Toyota Stadium", actual.venue
    assert_equal "/api/v1/venues/null", actual.venue_link
  end
end
