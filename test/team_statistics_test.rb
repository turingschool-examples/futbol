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

  def test_most_goals_scored
    assert_equal 1, @team_statistics.most_goals_scored("5")
    assert_equal 2, @team_statistics.most_goals_scored("3")
    assert_equal 4, @team_statistics.most_goals_scored("6")
  end

  def test_fewest_goals_scored
    assert_equal 0, @team_statistics.fewest_goals_scored("5")
    assert_equal 1, @team_statistics.fewest_goals_scored("3")
    assert_equal 1, @team_statistics.fewest_goals_scored("6")
  end

  def test_favorite_opponent
    assert_equal "Houston Dynamo", @team_statistics.favorite_opponent("6")
    assert_equal "Philadelphia Union", @team_statistics.favorite_opponent("22")
  end

  def test_rival
    assert_equal "Washington Spirit FC", @team_statistics.rival("24")
    assert_equal "Orlando Pride", @team_statistics.rival("17")
  end
end
