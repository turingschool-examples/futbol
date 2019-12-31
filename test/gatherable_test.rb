require_relative 'test_helper'
require './lib/modules/gatherable'
require './lib/modules/calculateable'
require './lib/tracker'
require './lib/stat_tracker'

class GatherableTest < Minitest::Test
  include Gatherable
  include Calculateable

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = Tracker.from_csv(locations)
  end

  def test_gatherable_exists
    gatherable = Gatherable

    assert_equal Gatherable, gatherable
  end
end
