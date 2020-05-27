require 'minitest/autorun'
require 'minitest/pride'
require './test/setup'
require './lib/game'
require './lib/team'
require './lib/game_collection'
require './lib/team_collection'
require './lib/stat_tracker'
require 'pry'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './fixtures/games_fixture.csv'
    team_path = './fixtures/teams_fixture.csv'
    game_teams_path = './fixtures/game_teams_fixture.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_csv_paths
    assert_equal './fixtures/games_fixture.csv', @stat_tracker.games_path
    assert_equal './fixtures/teams_fixture.csv', @stat_tracker.teams_path
    assert_equal './fixtures/game_teams_fixture.csv', @stat_tracker.game_teams_path
  end

  def test_it_has_games
    assert_instance_of Game, @stat_tracker.games.first
    assert_equal 2012030221, @stat_tracker.games.first.game_id
    assert_equal 20122013, @stat_tracker.games.first.season
    assert_equal 3, @stat_tracker.games.first.away_team_id
    assert_equal 6, @stat_tracker.games.first.home_team_id
  end

  def test_it_has_teams
    assert_instance_of Team, @stat_tracker.teams.first
    assert_equal 1, @stat_tracker.teams.first.team_id
    assert_equal 23, @stat_tracker.teams.first.franchise_id
    assert_equal "Atlanta United", @stat_tracker.teams.first.team_name
    assert_equal "ATL", @stat_tracker.teams.first.abbreviation
    assert_equal "/api/v1/teams/1", @stat_tracker.teams.first.link
  end
end
