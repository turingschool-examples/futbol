require_relative 'test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
                }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    @stat_tracker1 = StatTracker.new
    assert_instance_of StatTracker, @stat_tracker
  end

end
