require "minitest/autorun"
require "minitest/pride"
require "./lib/game"
require "./lib/game_loader"
require "mocha/minitest"

class GameTest < Minitest::Test
  def setup
    data = {
            'game_id'      => '2012030221',
            'season'       => '20122013',
            'type'         => 'Postseason',
            'date_time'    => '5/16/13',
            'away_team_id' => '3',
            'home_team_id' => '6',
            'away_goals'   => '2',
            'home_goals'   => '3',
            'venue'        => 'Toyota Stadium',
            'venue_link'   => '/api/v1/venues/null'
          }
    loader = mock('GameLoader')
    @game = Game.new(data, loader)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Game, @game
  end
end
