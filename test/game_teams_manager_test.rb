require_relative 'test_helper'

class GameTeamsManagerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  @stat_tracker = StatTracker.from_csv(locations)
  @game_statistics = GameTeamsManager.new('./data/game_teams.csv', @stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameTeamsManager, @game_statistics
  end

  def test_can_get_hash_of_seasons
    assert_equal 1612, @game_statistics.hash_of_seasons("20122013").count
  end

  def test_group_by_coach
    assert_equal 34, @game_statistics.group_by_coach("20122013").keys.count
  end

  def test_coach_wins
    assert_equal 34, @game_statistics.coach_wins("20122013").keys.count
  end

  def test_winningest_coach
    assert_equal "Dan Lacroix", @game_statistics.winningest_coach("20122013")
    assert_equal "Claude Julien", @game_statistics.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @game_statistics.winningest_coach("20142015")
    assert_equal "Barry Trotz", @game_statistics.winningest_coach("20152016")
    assert_equal "Bruce Cassidy", @game_statistics.winningest_coach("20162017")
    assert_equal "Bruce Cassidy", @game_statistics.winningest_coach("20172018")
  end

  def test_worst_coach
    assert_equal "Martin Raymond", @game_statistics.worst_coach("20122013")
    assert_equal "Peter Laviolette", @game_statistics.worst_coach("20132014")
    assert_equal "Ted Nolan", @game_statistics.worst_coach("20142015")
    assert_equal "Todd Richards", @game_statistics.worst_coach("20152016")
    assert_equal "Dave Tippett", @game_statistics.worst_coach("20162017")
    assert_equal "Phil Housley", @game_statistics.worst_coach("20172018")
  end

  def test_it_can_group_by_team_id
    assert_equal 30, @game_statistics.find_by_team_id("20132014").count
  end

  def test_it_can_calculate_goals_to_shots_ratio
    assert_equal 30, @game_statistics.goals_to_shots_ratio_per_season("20122013").count
  end

  def test_it_can_find_the_most_accurate_team
    assert_equal 24, @game_statistics.find_most_accurate_team("20132014")
  end

  def test_it_can_find_most_accurate_team_name
    assert_equal "Real Salt Lake", @game_statistics.most_accurate_team("20132014")
    assert_equal "Toronto FC", @game_statistics.most_accurate_team("20142015")
  end

  def test_it_can_find_least_accurate_team_name
    assert_equal "New York City FC", @game_statistics.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @game_statistics.least_accurate_team("20142015")
  end

  def test_it_can_find_the_least_accurate_team
    assert_equal 9, @game_statistics.find_least_accurate_team("20132014")
  end

  def test_it_can_calculate_total_tackles
    assert_equal 30, @game_statistics.total_tackles("20132014").count
  end

  def test_it_can_find_the_team_with_most_tackles
    assert_equal 26, @game_statistics.find_team_with_most_tackles("20132014")
  end

  def test_can_find_team_name_with_most_tackles_in_season
    assert_equal 'FC Cincinnati', @game_statistics.most_tackles("20132014")
    assert_equal 'Seattle Sounders FC', @game_statistics.most_tackles("20142015")
  end

  def test_it_can_find_the_team_with_fewest_tackles
    assert_equal 1, @game_statistics.find_team_with_fewest_tackles("20132014")
  end

  def test_can_find_team_name_with_fewest_tackles_in_season
    assert_equal 'Atlanta United', @game_statistics.fewest_tackles("20132014")
    assert_equal 'Orlando City SC', @game_statistics.fewest_tackles("20142015")
  end
end
