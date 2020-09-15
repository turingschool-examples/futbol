require_relative 'test_helper'

class SeasonStatsTest < Minitest::Test
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
  @season_stats = SeasonStats.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of SeasonStats, @season_stats
  end

  def test_group_by_coach
    assert_equal 34, @season_stats.group_by_coach("20122013").keys.count
  end

  def test_coach_wins
    assert_equal 34, @season_stats.coach_wins("20122013").keys.count
  end

  def test_can_get_games_from_season
    assert_equal 1612, @season_stats.games_from_season("20122013").count
  end

  def test_winningest_coach
    assert_equal "Dan Lacroix", @season_stats.winningest_coach("20122013")
    assert_equal "Claude Julien", @season_stats.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @season_stats.winningest_coach("20142015")
    assert_equal "Barry Trotz", @season_stats.winningest_coach("20152016")
    assert_equal "Bruce Cassidy", @season_stats.winningest_coach("20162017")
    assert_equal "Bruce Cassidy", @season_stats.winningest_coach("20172018")
  end

  def test_worst_coach
    assert_equal "Martin Raymond", @season_stats.worst_coach("20122013")
    assert_equal "Peter Laviolette", @season_stats.worst_coach("20132014")
    assert_equal "Ted Nolan", @season_stats.worst_coach("20142015")
    assert_equal "Todd Richards", @season_stats.worst_coach("20152016")
    assert_equal "Dave Tippett", @season_stats.worst_coach("20162017")
    assert_equal "Phil Housley", @season_stats.worst_coach("20172018")
  end

  def test_it_can_group_by_team_id
    assert_equal 30, @season_stats.find_by_team_id("20132014").count
  end

  def test_it_can_calculate_goals_to_shots_ratio
    assert_equal 30, @season_stats.goals_to_shots_ratio_per_season("20122013").count
  end

  def test_it_can_find_the_most_accurate_team_id
    assert_equal 24, @season_stats.find_most_accurate_team("20132014")
  end

  def test_it_can_find_most_accurate_team_name
    assert_equal "Real Salt Lake", @season_stats.most_accurate_team("20132014")
    assert_equal "Toronto FC", @season_stats.most_accurate_team("20142015")
  end

  def test_it_can_find_the_least_accurate_team
    assert_equal 9, @season_stats.find_least_accurate_team("20132014")
  end

  def test_it_can_find_least_accurate_team_name
    assert_equal "New York City FC", @season_stats.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @season_stats.least_accurate_team("20142015")
  end

  def test_it_can_calculate_total_tackles
    assert_equal 30, @season_stats.total_tackles("20132014").count
  end

  def test_it_can_find_the_team_with_most_tackles
    assert_equal 26, @season_stats.find_team_with_most_tackles("20132014")
  end

  def test_can_find_team_name_with_most_tackles_in_season
    assert_equal 'FC Cincinnati', @season_stats.most_tackles("20132014")
    assert_equal 'Seattle Sounders FC', @season_stats.most_tackles("20142015")
  end

  def test_it_can_find_the_team_with_fewest_tackles
    assert_equal 1, @season_stats.find_team_with_fewest_tackles("20132014")
  end
  
  def test_can_find_team_name_with_fewest_tackles_in_season
    assert_equal 'Atlanta United', @season_stats.fewest_tackles("20132014")
    assert_equal 'Orlando City SC', @season_stats.fewest_tackles("20142015")
  end
end
