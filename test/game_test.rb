require "./test/test_helper"
require "./lib/game"

class GameTest < Minitest::Test

  def setup
    game_data1 = {
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

    @game1 = Game.new(game_data1)

    game_data1 = {
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

    @game2 = Game.new(game_data1)
  end

  def test_it_exists
    assert_instance_of Game, @game1
  end

  def test_it_has_attributes

    assert_equal 2012030221,            @game1.id
    assert_equal 20122013,              @game1.season
    assert_equal "Postseason",          @game1.type
    assert_equal "5/16/13",             @game1.date_time
    assert_equal 3,                     @game1.away_team_id
    assert_equal 6,                     @game1.home_team_id
    assert_equal 2,                     @game1.away_goals
    assert_equal 3,                     @game1.home_goals
    assert_equal "Toyota Stadium",      @game1.venue
    assert_equal "/api/v1/venues/null", @game1.venue_link

  end

  def test_it_can_return_total_goals
    assert_equal 5, @game1.total_goals
  end

  def test_home_win
    assert_equal true, @game1.home_win?
  end

  def test_away_win
    assert_equal false, @game1.away_win?
  end

end

# === DONE ===
# * ID
# * home_goals
# * away_goals
# * season
# > total_goals
# > home_win?
# === TODO ===
# > away_win?
# > tie?
