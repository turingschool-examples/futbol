require './test/test_helper'
require './lib/stat_tracker'
require './lib/season_statistics'
require 'pry'

class SeasonStatisticsTest < Minitest::Test

  def setup
  game_path = './data/games_fixture.csv'
  team_path = './data/teams.csv'
  game_teams_path = './data/game_teams_fixture.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }
  @stat_tracker = StatTracker.from_csv(locations)
  @season_statistics = @stat_tracker.season_statistics
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  def test_has_readable_attributes
    assert_equal "2012030221", @season_statistics.game_collection[0].game_id
  end

  def test_current_season_games
    assert_equal ["2013020674", "2013020177", "2013021085"] , @season_statistics.current_season_games("20132014")
  end

  def test_current_season_game_teams
    assert_instance_of GameTeam, @season_statistics.current_season_game_teams("20122013").first
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @season_statistics.coach_win_loss_results("20122013", "high")
  end

  def test_losingest_coach
    assert_equal "John Tortorella", @season_statistics.coach_win_loss_results("20122013", "low")
  end

  def test_most_least_tackles
    assert_equal "Houston Dynamo", @season_statistics.most_least_tackles("20122013", "high")
    assert_equal "FC Dallas", @season_statistics.most_least_tackles("20122013", "low")
  end
end
