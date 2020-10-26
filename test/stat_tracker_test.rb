require_relative './test_helper'
require './lib/stat_tracker'



class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stattracker = StatTracker.from_csv(locations)
  end

  def test_it_exists_and_has_attributes

    assert_instance_of StatTracker, @stattracker
  end
end
