require_relative 'test_helper'
require 'mocha/minitest'

class SeasonStatistcsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat ||= StatTracker.new(@locations)

  end

  def test_it_exists
    @stat.coaches_per_season(@stat.find_all_seasons)
  end

  def test_find_all_seasons
    assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"], @stat.find_all_seasons
  end

  def test_coaches_per_season
    assert @stat.coaches_per_season(@stat.find_all_seasons)["20132014"].include?("Claude Julien")
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @stat.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat.winningest_coach("20142015")
  end

  def test_worst_coach
    assert_equal "Peter Laviolette", @stat.worst_coach("20132014")
    assert_includes ["Craig MacTavish", "Ted Nolan"], @stat.worst_coach("20142015")
  end

  def test_most_accurate_team
    assert_equal "Real Salt Lake", @stat.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat.most_accurate_team("20142015")
  end

  def test_least_accurate_team
  assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
  assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
 end

 def test_most_tackles_by_season
   assert_equal "FC Cincinnati", @stat.most_tackles("20132014")
   assert_equal "Seattle Sounders FC", @stat.most_tackles("20142015")
 end

 def test_most_tackles_by_season
   assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
   assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
 end

end
