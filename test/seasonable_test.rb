require './test/test_helper'
require './lib/seasonable'

class SeasonableTest < Minitest::Test

  # Name of the team with the biggest decrease between regular season and postseason win percentage.	Return: String
  #BB
  def test_biggest_bust
    skip
    assert_equal "Montreal Impact", @stat_tracker.biggest_bust("20132014")
    assert_equal "Sporting Kansas City", @stat_tracker.biggest_bust("20142015")
  end

  # Name of the team with the biggest increase between regular season and postseason win percentage.	Return: String
  #BB
  def test_biggest_surprise
    skip
    assert_equal "FC Cincinnati", @stat_tracker.biggest_surprise("20132014")
    assert_equal "Minnesota United FC", @stat_tracker.biggest_surprise("20142015")
  end

  # Name of the Coach with the best win percentage for the season. Return:	String
  #JP
  def test_winningest_coach
    skip
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  end

  # Name of the Coach with the worst win percentage for the season. Return:	String
  #JP
  def test_worst_coach
    skip
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    assert_equal "Craig MacTavish", @stat_tracker.worst_coach("20142015")
  end

  # Name of the Team with the best ratio of shots to goals for the season. Return:	String
  #AM
  def test_most_accurate_team
    skip
    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  # Name of the Team with the worst ratio of shots to goals for the season. Return:	String
  #AM
  def test_least_accurate_team
    skip
    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  # Name of the Team with the most tackles in the season. Return:	String
  #AM
  def test_most_tackles
    skip
    assert_equal "FC Cincinnati", @stat_tracker.most_tackles("20132014")
    assert_equal "Seattle Sounders FC", @stat_tracker.most_tackles("20142015")
  end

  # Name of the Team with the fewest tackles in the season. Return:	String
  #AM
  def test_fewest_tackles
    skip
    assert_equal "Atlanta United", @stat_tracker.fewest_tackles("20132014")
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20142015")
  end

end
