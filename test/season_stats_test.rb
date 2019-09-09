require_relative 'test_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/games'
require_relative '../lib/teams'
require_relative '../lib/game_teams'

class SeasonStatsTest < MiniTest::Test

  def setup
    locations = { games: './data/dummy_games.csv', teams: './data/teams.csv', game_teams: './data/dummy_game_teams.csv' }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_biggest_bust
    assert_equal "Montreal Impact", @stat_tracker.biggest_bust("20132014")
    assert_equal "Sporting Kansas City", @stat_tracker.biggest_bust("20142015")
  end

  def test_biggest_surprise
    skip
    assert_equal "FC Cincinnati", @stat_tracker.biggest_surprise("20132014")
    assert_equal "Minnesota United FC", @stat_tracker.biggest_surprise("20142015")
  end

  def test_winningest_coach
    skip
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  def test_worst_coach
    skip
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    assert_equal "Craig MacTavish", @stat_tracker.worst_coach("20142015")
  end

  def test_most_accurate_team
    skip
    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  def test_least_accurate_team
    skip
    assert_equal "New York City FC", @stat_track.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_track.least_accurate_team("20142015")
  end

  def test_most_tackles
    skip
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_track.most_tackles("20142015")
  end

  def test_fewest_tackles
    skip
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end


  

end
