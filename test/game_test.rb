require "./test/test_helper"
require "./lib/game"

class GameTest < Minitest::Test

  def setup
    game_data = {
      id:           2012030221,
      season:       20122013,
      type:         "Postseason",
      date_time:    "5/16/13",
      away_team_id: 3,
      home_team_id: 6,
      away_goals:   2,
      home_goals:   3,
      venue:        "Toyota Stadium",
      venue_link:   "/api/v1/venues/null"
    }

    @game = Game.new(game_data)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

end

# === DONE ===
# * ID
# * home_goals
# * away_goals
# * season


# > total_goals
# > home_win?
# > away_win?
# > tie?
