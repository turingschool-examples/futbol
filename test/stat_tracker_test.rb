require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def test_stat_tracker_exists
    new_tracker = StatTracker.new('games', 'teams', 'team_games')

    assert_instance_of StatTracker, new_tracker
  end

  def test_stat_tracker_from_csv
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }
    # change assert collection to truncated files
    stat_tracker = StatTracker.from_csv(locations)
    game = ["2012030221", "20122013", "Postseason", "5/16/13", "3", "6", "2", "3", "Toyota Stadium", "/api/v1/venues/null"]
    team = ["14", "31", "DC United", "DC", "Audi Field", "/api/v1/teams/14"]
    game_teams = ["2012030222", "3", "away", "LOSS", "REG", "John Tortorella", "2", "9", "33", "11", "5", "0", "51.7", "1", "4"]

    assert_includes(stat_tracker.games, game)
    assert_includes(stat_tracker.teams, team)
    assert_includes(stat_tracker.game_teams, game_teams)
  end
end
