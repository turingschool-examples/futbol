require './test/test_helper'
require './lib/stat_tracker'
class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @file_locations = {
                      games: @game_path,
                      teams: @team_path,
                      game_teams: @game_teams_path
                        }
  end

  def test_it_exists_and_has_attributes
    stat_tracker = StatTracker.from_csv(@file_locations)
    assert_instance_of StatTracker, stat_tracker
  end
end
