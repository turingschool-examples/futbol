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

  def test_ligatures_for_dopeness
    a_string = 'This is a string.'
    b_string = 'This is b string, I think.'
    c_string = { this_is_a_hash_key_symbol: :and_a_hash_value_symbol }

    (c_string != { 'some_string' => 011010010001 })

    a_string <= b_string || a_string >= b_string

    (c_string * (4 / 2 + 20 - 23)).join.length

    (c_string.length == b_string.length)

    a_string <=> 'Wow, more ligatures.'
  end
end
