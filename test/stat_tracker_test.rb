require_relative 'test_helper'
require './lib/stat_tracker'
require './lib/game_statistics'

class StatTrackerTest < Minitest::Test
  def test_it_exists
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }

    stat_tracker = StatTracker.new(locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_from_csv
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_has_attributes
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }

    stat_tracker = StatTracker.new(locations)

    assert_equal './data/games.csv', stat_tracker.games
    assert_equal './data/teams.csv', stat_tracker.teams
    assert_equal './data/game_teams.csv', stat_tracker.game_teams
  end

  def test_game_stats
    data = {:game_id => [], :season => [], :type => [], :date_time => [], :away_team_id => [], :home_team_id => [], :away_goals => [], :home_goals => []}
    locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }

    stat_tracker = StatTracker.new(locations)

    assert_equal 8, stat_tracker.game_stats(data).count
  end

end
