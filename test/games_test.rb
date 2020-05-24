require './test/helper_test'
require './lib/stat_tracker'
require './lib/games'

class GamesTest < Minitest::Test

  def test_it_exists
    stat_tracker = StatTracker.from_csv(
    locations = {
      games: './data/games.csv'
      })
    assert_instance_of StatTracker, stat_tracker
  end


end
