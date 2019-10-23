require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_collection'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    stat_tracker = StatTracker.new('./data/games_sample.csv', './data/teams.csv', './data/game_teams.csv')
    assert_instance_of StatTracker, stat_tracker
  end

end
