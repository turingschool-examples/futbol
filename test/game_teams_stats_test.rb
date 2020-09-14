require_relative 'test_helper'

class GameTeamsStatsTest < Minitest::Test
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
  @game_teams_stats = GameTeamsStats.new('./data/game_teams.csv', @stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameTeamsStats, @game_teams_stats
  end

  def test_can_get_hash_of_seasons
    assert_equal 1612, @game_teams_stats.hash_of_seasons("20122013").count
  end

  def test_group_by_coach
    assert_equal 34, @game_teams_stats.group_by_coach("20122013").keys.count
  end

  def test_coach_wins
    assert_equal 34, @game_teams_stats.coach_wins("20122013").keys.count
  end

  def test_winningest_coach
    assert_equal "Dan Lacroix", @game_teams_stats.winningest_coach("20122013")
    assert_equal "Claude Julien", @game_teams_stats.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @game_teams_stats.winningest_coach("20142015")
    assert_equal "Barry Trotz", @game_teams_stats.winningest_coach("20152016")
    assert_equal "Bruce Cassidy", @game_teams_stats.winningest_coach("20162017")
    assert_equal "Bruce Cassidy", @game_teams_stats.winningest_coach("20172018")
  end

  def test_worst_coach
    assert_equal "Martin Raymond", @game_teams_stats.worst_coach("20122013")
    assert_equal "Peter Laviolette", @game_teams_stats.worst_coach("20132014")
    assert_equal "Ted Nolan", @game_teams_stats.worst_coach("20142015")
    assert_equal "Todd Richards", @game_teams_stats.worst_coach("20152016")
    assert_equal "Dave Tippett", @game_teams_stats.worst_coach("20162017")
    assert_equal "Phil Housley", @game_teams_stats.worst_coach("20172018")
  end

  def test_it_can_group_by_team_id
    assert_equal 30, @game_teams_stats.find_by_team_id("20132014").count
  end

  def test_it_can_calculate_goals_to_shots_ratio
    assert_equal 30, @game_teams_stats.goals_to_shots_ratio_per_season("20122013").count
  end

  def test_it_can_find_the_most_accurate_team
    assert_equal 24, @game_teams_stats.find_most_accurate_team("20132014")
  end

  def test_it_can_find_most_accurate_team_name
    assert_equal "Real Salt Lake", @game_teams_stats.most_accurate_team("20132014")
    assert_equal "Toronto FC", @game_teams_stats.most_accurate_team("20142015")
  end

  def test_it_can_find_least_accurate_team_name
    assert_equal "New York City FC", @game_teams_stats.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @game_teams_stats.least_accurate_team("20142015")
  end

  def test_it_can_find_the_least_accurate_team
    assert_equal 9, @game_teams_stats.find_least_accurate_team("20132014")
  end

  def test_it_can_calculate_total_tackles
    assert_equal 30, @game_teams_stats.total_tackles("20132014").count
  end

  def test_it_can_find_the_team_with_most_tackles
    assert_equal 26, @game_teams_stats.find_team_with_most_tackles("20132014")
  end

  def test_can_find_team_name_with_most_tackles_in_season
    assert_equal 'FC Cincinnati', @game_teams_stats.most_tackles("20132014")
    assert_equal 'Seattle Sounders FC', @game_teams_stats.most_tackles("20142015")
  end

  def test_it_can_find_the_team_with_fewest_tackles
    assert_equal 1, @game_teams_stats.find_team_with_fewest_tackles("20132014")
  end

  def test_can_find_team_name_with_fewest_tackles_in_season
    assert_equal 'Atlanta United', @game_teams_stats.fewest_tackles("20132014")
    assert_equal 'Orlando City SC', @game_teams_stats.fewest_tackles("20142015")
  end
end
