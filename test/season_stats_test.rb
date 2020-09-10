require_relative 'test_helper'
require "./lib/game_statistics"
require './lib/stat_tracker'
require './lib/season_stats'

class SeasonStatisticsTest < Minitest::Test
  def setup
    # game_teams: head_coach, result, team_id, shots, goals, tackles
    # games: season, team_id
    # teams: teamName, team_id
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @raw_game_stats = @stat_tracker.game_stats
    @raw_game_teams_stats = @stat_tracker.game_teams_stats
    @raw_teams_stats = @stat_tracker.teams_stats
    @season_statistics = SeasonStatistics.new(@raw_game_stats, @raw_game_teams_stats, @raw_teams_stats)
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  def test_it_has_attributes
    assert_equal 7441, @season_statistics.game_data.length
    assert_equal 32, @season_statistics.teams_data.length
    assert_equal 14882, @season_statistics.game_teams_data.length
  end

  def test_can_get_hash_of_seasons
    assert_equal 1612, @season_statistics.hash_of_seasons("20122013").count
  end

  def test_group_by_coach
    assert_equal 34, @season_statistics.group_by_coach("20122013").keys.count
  end

  def test_coach_wins
    assert_equal 34, @season_statistics.coach_wins("20122013").keys.count
  end

  def test_winningest_coach
    assert_equal "Dan Lacroix", @season_statistics.winningest_coach("20122013")
    assert_equal "Claude Julien", @season_statistics.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @season_statistics.winningest_coach("20142015")
    assert_equal "Barry Trotz", @season_statistics.winningest_coach("20152016")
    assert_equal "Bruce Cassidy", @season_statistics.winningest_coach("20162017")
    assert_equal "Bruce Cassidy", @season_statistics.winningest_coach("20172018")
  end

  def test_worst_coach
    assert_equal "Martin Raymond", @season_statistics.worst_coach("20122013")
    assert_equal "Peter Laviolette", @season_statistics.worst_coach("20132014")
    assert_equal "Ted Nolan", @season_statistics.worst_coach("20142015")
    assert_equal "Todd Richards", @season_statistics.worst_coach("20152016")
    assert_equal "Dave Tippett", @season_statistics.worst_coach("20162017")
    assert_equal "Phil Housley", @season_statistics.worst_coach("20172018")
  end

  def test_it_can_group_by_team_id
    assert_equal 30, @season_statistics.find_by_team_id("20132014").count
  end

  def test_it_can_calculate_goals_to_shots_ratio
    assert_equal 30, @season_statistics.goals_to_shots_ratio_per_season("20122013").count
  end

  def test_it_can_find_the_most_accurate_team
    assert_equal 24, @season_statistics.find_most_accurate_team("20132014")
  end

  def test_it_can_find_most_accurate_team_name
    assert_equal "Real Salt Lake", @season_statistics.most_accurate_team("20132014")
    assert_equal "Toronto FC", @season_statistics.most_accurate_team("20142015")
  end
end
