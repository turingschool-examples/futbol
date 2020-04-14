require './test/test_helper'
require './lib/stat_tracker'
require './lib/team_statistics'
require 'mocha/minitest'
require 'pry'

class TeamStatisticsTest < Minitest::Test

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
    @team_statistics = @stat_tracker.team_statistics
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end

  def test_it_has_readable_attributes
    assert_instance_of Array, @team_statistics.game_collection
    assert_instance_of Array, @team_statistics.game_teams_collection
    assert_instance_of Array, @team_statistics.teams_collection

    assert_equal "2012030221", @team_statistics.game_collection[0].game_id
    assert_equal "2014030326", @team_statistics.game_collection[-1].game_id

    assert_equal "2012030221", @team_statistics.game_teams_collection[0].game_id
    assert_equal "2012030124", @team_statistics.game_teams_collection[-1].game_id

    assert_equal "1", @team_statistics.teams_collection[0].id
    assert_equal "53", @team_statistics.teams_collection[-1].id
  end

  def test_team_info
    expected1 = {"team_id" => "1", "franchise_id" => "23", "team_name" => "Atlanta United", "abbreviation" => "ATL", "link" => "/api/v1/teams/1"}
    expected2 = {"team_id" => "4", "franchise_id" => "16", "team_name" => "Chicago Fire", "abbreviation" => "CHI", "link"=> "/api/v1/teams/4"}

    assert_equal expected1, @team_statistics.team_info("1")
    assert_equal expected2, @team_statistics.team_info("4")
  end

  def test_games_played
    assert_instance_of Array, @team_statistics.games_played("3")
    games_played = @team_statistics.games_played("3")
    assert_equal "2012030221", games_played[0].game_id
    assert_equal "2012030225", games_played[-1].game_id
  end

  def test_best_season
      assert_equal "20132014", @team_statistics.best_season("24")
  end

  def test_worst_season
    assert_equal "20142015", @team_statistics.worst_season("24")
  end

  def test_average_win_percentage
    assert_equal 0.33, @team_statistics.average_win_percentage("22")
    assert_equal 0, @team_statistics.average_win_percentage("3")
    assert_equal 1, @team_statistics.average_win_percentage("6")
  end

  # Rewrite using info from game_teams fixture
  def test_goals_scored_high_and_low
    skip
    assert_equal 1, @team_statistics.goals_scored_high_and_low("5", "high")
    assert_equal 2, @team_statistics.goals_scored_high_and_low("3", "high")
    assert_equal 4, @team_statistics.goals_scored_high_and_low("6", "high")

    assert_equal 0, @team_statistics.goals_scored_high_and_low("5", "low")
    assert_equal 1, @team_statistics.goals_scored_high_and_low("3", "low")
    assert_equal 1, @team_statistics.goals_scored_high_and_low("6", "low")
  end

  def test_opponent_preference
    assert_equal "Houston Dynamo", @team_statistics.opponent_preference("6", "high")
    assert_equal "Philadelphia Union", @team_statistics.opponent_preference("22", "high")
    assert_equal "Washington Spirit FC", @team_statistics.opponent_preference("24", "low")
    assert_equal "Orlando Pride", @team_statistics.opponent_preference("17", "low")
  end

end
