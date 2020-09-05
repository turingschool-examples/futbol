require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  # def test_it_exists
  #   game_path = './data/games_dummy.csv'
  #   team_path = './data/teams_dummy.csv'
  #   game_teams_path = './data/game_teams_dummy.csv'
  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #   }
  #   stat_tracker = StatTracker.new(game_path, team_path, game_teams_path)
  #   assert_instance_of StatTracker, stat_tracker
  # end
  #
  # def test_readable_attributes
  #   game_path = './data/games_dummy.csv'
  #   team_path = './data/teams_dummy.csv'
  #   game_teams_path = './data/game_teams_dummy.csv'
  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #   }
  #   stat_tracker = StatTracker.new(game_path, team_path, game_teams_path)
  #   require "pry"; binding.pry
  #   assert_equal [], stat_tracker.games
  #   assert_equal [], stat_tracker.teams
  #   assert_equal [], stat_tracker.game_teams
  # end

  def test_it_exists
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_can_read_csv_data
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    # expected_games = [<Game game_id="2012030221", season="20122013", type="Postseason", date_time="5/16/13", away_team_id="3", home_team_id="6", away_goals="2", home_goals="3", venue="Toyota Stadium", venue_link="/api/v1/venues/null">]

    assert_instance_of StatTracker::Game, stat_tracker.games.pop
    # assert_equal expected_games, stat_tracker.games
    # assert_equal [], stat_tracker.teams
    # assert_equal [], stat_tracker.game_teams
  end

end
