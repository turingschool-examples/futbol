require "minitest/autorun"
require "minitest/pride"
require "./lib/modules/teamable"
require "./lib/stat_tracker"
require "pry"


class TeamableModuleTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/games.csv'
    team_path = './data/dummy_data/teams.csv'
    game_team_path = './data/dummy_data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_team_info
    expected_hash = {
      "team_id" => "3" ,
      "team_name" => "Houston Dynamo",
      "franchise_id" => "10",
      "abbreviation" => "HOU",
      "link" => "/api/v1/teams/3"
    }
    assert_equal expected_hash, @stat_tracker.team_info("3")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("3")
  end

  def test_worst_season
    assert_equal "20142015", @stat_tracker.worst_season("3")
  end

  def test_average_win_percentage
    assert_equal 0.57, @stat_tracker.average_win_percentage("3")
  end

  def test_most_goals_scored
    assert_equal 3, @stat_tracker.most_goals_scored("3")
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored("3")
  end

  def test_favorite_opponent
    assert_equal "Chicago Fire", @stat_tracker.favorite_opponent("3")
  end

  def test_rival
    assert_equal "Sporting Kansas City", @stat_tracker.rival("3")
  end

  def test_biggest_team_blowout
    assert_equal 2, @stat_tracker.biggest_team_blowout("3")
  end

  def test_worst_loss
    assert_equal 2, @stat_tracker.worst_loss("3")
  end

  def test_head_to_head
    expected_hash = {
      "Chicago Fire" => 0.67,
      "Sporting Kansas City" => 0.5
    }
    assert_equal expected_hash, @stat_tracker.head_to_head("3")
  end

  def test_seasonal_summary
    expected_hash = {
      "20132014" => {
        regular_season: {
          win_percentage: 0.5,
          total_goals_scored: 11,
          total_goals_against: 7,
          average_goals_scored: 2.75,
          average_goals_against: 1.75
        },
        postseason: {
          win_percentage: 0.75,
          total_goals_scored: 7,
          total_goals_against: 6,
          average_goals_scored: 1.75,
          average_goals_against: 1.5
        }
      },
      "20142015" => {
        regular_season: {
          win_percentage: 0.25,
          total_goals_scored: 9,
          total_goals_against: 9,
          average_goals_scored: 2.25,
          average_goals_against: 2.25
          },
        postseason: {
          win_percentage: 1.0,
          total_goals_scored: 4,
          total_goals_against: 2,
          average_goals_scored: 2.0,
          average_goals_against: 1.0
        }
      }
    }
    assert_equal expected_hash, @stat_tracker.seasonal_summary("3")
  end
end
