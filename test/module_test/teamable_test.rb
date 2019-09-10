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
    skip
    assert_equal 2, @stat_tracker.biggest_blowout("3")
  end

  def test_worst_loss
    skip
    assert_equal 2, @stat_tracker.worst_loss("3")
  end

  def test_head_to_head
    skip
    expected_hash = {
      "Chicago Fire" => 1.0,
      "Sporting Kansas City" => 0.6
    }
    assert_equal expected_hash, @stat_tracker.head_to_head("3")
  end

  def test_seasonal_summary
    skip
    expected_hash = {
     "20132014" => {
       regular_season: {
         win_percentage: nil,
         total_goals_scored: nil,
         total_goals_against: nil,
         average_goals_scored: nil,
         average_goals_against: nil
        },
       postseason:{
         win_percentage: nil,
         total_goals_scored: nil,
         total_goals_against: nil,
         average_goals_scored: nil,
         average_goals_against: nil
       }
     },
    "20142015" => {
       regular_season: {
         win_percentage: nil,
         total_goals_scored: nil,
         total_goals_against: nil,
         average_goals_scored: nil,
         average_goals_against: nil
        },
       postseason:{
         win_percentage:nil ,
         total_goals_scored: nil,
         total_goals_against: nil,
         average_goals_scored: nil,
         average_goals_against: nil
       }
      }
     }
    assert_equal expected_hash, @stat_tracker.seasonal_summary("3")
  end
end
