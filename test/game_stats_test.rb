require_relative 'test_helper'

class GameStatsTest < Minitest::Test

  def setup
    @info = { :game_id => "2012030221",
              :team_id => 3,
              :hoa => "away",
              :result => "LOSS",
              :settled_in => "OT",
              :head_coach => "John Tortorella",
              :goals => 2,
              :shots => 8,
              :tackles => 44,
              :pim => 8,
              :powerplayopportunities => 3,
              :powerplaygoals => 0,
              :faceoffwinpercentage => 44.8,
              :giveaways => 17,
              :takeaways => 7}
      @game_stats = GameStats.new(@info)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game_stats.game_id
    assert_equal 3, @game_stats.team_id
    assert_equal "away", @game_stats.home_away
    assert_equal "LOSS", @game_stats.result
    assert_equal "OT", @game_stats.settled_in
    assert_equal "John Tortorella", @game_stats.head_coach
    assert_equal 2, @game_stats.goals
    assert_equal 8, @game_stats.shots
    assert_equal 44, @game_stats.tackles
    assert_equal 8, @game_stats.pim
    assert_equal 3, @game_stats.power_play_opportunities
    assert_equal 0, @game_stats.power_play_goals
    assert_equal 44.8, @game_stats.face_off_win_percentage
    assert_equal 17, @game_stats.giveaways
    assert_equal 7, @game_stats.takeaways
  end
end
