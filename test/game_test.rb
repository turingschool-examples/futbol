require './test/test_helper'
require './lib/game'
require 'csv'

class GameTest < Minitest::Test
  def setup
    expected = {
    game_id: 2017030161,
    season: "20172018",
    type: 'Postseason',
    date_time: '4/11/18',
    away_team_id: "30",
    home_team_id: "52",
    away_goals: 2,
    home_goals: 3,
    venue: 'Providence Park',
    venue_link: '/api/v1/venues/null'}

    @game = Game.new(expected)
    @game_data = CSV.read('./test/fixtures/games_fixture.csv', headers: true, header_converters: :symbol)

    @game_1 = Game.new(@game_data[16])
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_game_has_attributes
    assert_equal 2017030161, @game.game_id
    assert_equal "20172018", @game.season
    assert_equal "Postseason", @game.type
    assert_equal "4/11/18", @game.date_time
    assert_equal "30", @game.away_team_id
    assert_equal "52", @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "Providence Park", @game.venue
    assert_equal '/api/v1/venues/null', @game.venue_link
  end

  def test_game_reads_from_CSV
    assert_equal 2013020674, @game_1.game_id
    assert_equal "20132014", @game_1.season
    assert_equal "Regular Season", @game_1.type
    assert_equal "1/11/14", @game_1.date_time
    assert_equal "19", @game_1.away_team_id
    assert_equal "23", @game_1.home_team_id
    assert_equal 1, @game_1.away_goals
    assert_equal 2, @game_1.home_goals
    assert_equal "Saputo Stadium", @game_1.venue
    assert_equal '/api/v1/venues/null', @game_1.venue_link
  end

end
