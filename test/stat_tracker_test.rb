require './test/test_helper'
require './lib/stat_tracker'


class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_existence_of_stat_tracker_and_creations
    assert_instance_of Game, @stat_tracker.games.first
    assert_instance_of Team, @stat_tracker.teams.first
    assert_instance_of GameTeam, @stat_tracker.game_teams.first
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_game_instance_variables
    assert_equal ('2012020122'), @stat_tracker.games.first.game_id
    assert_equal ('20122013'), @stat_tracker.games.first.season
    assert_equal ('Regular Season'), @stat_tracker.games.first.type
    assert_equal ('2/3/13'), @stat_tracker.games.first.date_time
    assert_equal ('1'), @stat_tracker.games.first.away_team_id
    assert_equal ('2'), @stat_tracker.games.first.home_team_id
    assert_equal (3), @stat_tracker.games.first.away_goals
    assert_equal (0), @stat_tracker.games.first.home_goals
    assert_equal ('Centruy Link Field'), @stat_tracker.games.first.venue
    assert_equal ('/api/v1/venues/null'), @stat_tracker.games.first.venue_link
  end

  def test_team_instance_variables
    skip
  end

  def test_game_team_instance_variables
    skip
  end

end
