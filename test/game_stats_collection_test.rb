require_relative 'test_helper'

class GameStatsCollectionTest < Minitest::Test
  def setup
    @game_stats_collection = GameStatsCollection.new("./test/fixtures/truncated_game_teams.csv")
    @game_stats = @game_stats_collection.game_stats[0]
  end

  def test_it_exists
    assert_instance_of GameStatsCollection, @game_stats_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_stats_collection.game_stats
    assert_equal 217, @game_stats_collection.game_stats.length
  end

  def test_it_can_create_game_stats_from_csv
    assert_instance_of GameStats, @game_stats
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
