require_relative 'test_helper'

class GameStatsTest < Minitest::Test

  def setup
    @info = { :game_id => "2012030221",
              :team_id => 3,
              :HoA => "away",
              :result => "LOSS",
              :settled_in => "OT",
              :head_coach => "John Tortorella",
              :goals => 2,
              :shots => 8,
              :tackles => 44,
              :pim => 8,
              :powerPlayOpportunities => 3,
              :powerPlayGoals => 0,
              :faceOffWinPercentage => 44.8,
              :giveaways => 17,
              :takeaways => 7}
      @game_stats = GameStats.new(@info)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_equal "2012030221", @game_stats.game_id
    assert_equal 3, @game_stats.team_id
    assert_equal "away", @game_stats.HoA
    assert_equal "LOSS", @game_stats.result
    assert_equal "OT", @game_stats.settled_in
    assert_equal "John Tortorella", @game_stats.head_coach
    assert_equal 2, @game_stats.goals
    assert_equal 8, @game_stats.shots
    assert_equal 44, @game_stats.tackles
    assert_equal 8, @game_stats.pim
    assert_equal 3, @game_stats.powerPlayOpportunities
    assert_equal 0, @game_stats.powerPlayGoals
    assert_equal 44.8, @game_stats.faceOffWinPercentage
    assert_equal 17, @game_stats.giveaways
    assert_equal 7, @game_stats.takeaways
  end
end
