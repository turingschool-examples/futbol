require_relative 'test_helper'
require './lib/game_stats'
require './lib/stat_tracker'

class GameStatsTest < Minitest::Test
  def setup
    game_path = './data/games_truncated.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    @locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }
    @stat_tracker = StatTracker.from_csv(@locations)
    @game_stats = GameStats.new(@stat_tracker.games)
  end

  def test_it_exists
    assert_instance_of GameStats, @game_stats
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_stats.games
    assert_instance_of Game, @game_stats.games.first
  end

  def test_returns_highest_total_score
    assert_equal 6, @game_stats.highest_total_score
  end

  def test_returns_lowest_total_score
    assert_equal 3, @game_stats.lowest_total_score
  end

  def test_returns_biggest_blowout
    assert_equal 2, @game_stats.biggest_blowout
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.57, @game_stats.percentage_home_wins
  end

  def test_it_can_calculate_percentage_vistor_wins
    assert_equal 0.29, @game_stats.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.14, @game_stats.percentage_ties
  end

  def test_it_can_count_games_by_season
    games_by_season = {
      '20152016' => 3,
      '20132014' => 2,
      '20142015' => 1,
      '20162017' => 1
    }
    assert_equal games_by_season, @game_stats.count_of_games_by_season
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 4.71, @game_stats.average_goals_per_game
  end

  def test_it_can_calculate_average_goals_per_season
    goals_by_season = { '20152016' => 5.33, '20132014' => 5, '20142015' => 3,
      '20162017' => 4}
      assert_equal goals_by_season, @game_stats.average_goals_by_season
  end
end
