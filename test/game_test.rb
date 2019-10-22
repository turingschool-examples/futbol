require_relative 'test_helper'

class GameTest < Minitest::Test

  def setup
    @game_hash = {
                  game_id: 2012030221,
                  season: 20122013,
                  type: 'Postseason',
                  date_time: '5/16/13',
                  away_team_id: 3,
                  home_team_id: 6,
                  away_goals: 2,
                  home_goals: 3,
                  venue: 'Toyota Stadium',
                  venue_link: '/api/v1/venues/null'
                }

    @game_1 = Game.new(@game_hash)
  end

  def test_it_exists
    assert_instance_of Game, @game_1
  end

# assert_equal true, @instructor.preference
  def test_it_initializes_with_attributes
    assert_equal 2012030221, @game_1.game_id
    assert_equal 20122013, @game_1.season
    assert_equal 'Postseason', @game_1.type
    assert_equal '5/16/13', @game_1.date_time
    assert_equal 3, @game_1.away_team_id
    assert_equal 6, @game_1.home_team_id
    assert_equal 2, @game_1.away_goals
    assert_equal 3, @game_1.home_goals
    assert_equal 'Toyota Stadium', @game_1.venue
    assert_equal '/api/v1/venues/null', @game_1.venue_link
  end

end
