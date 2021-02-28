require './test/test_helper'

class GameTest < Minitest::Test
  def setup
    @game = Game.new({
            game_id: 2015030133,
            season: 20152016,
            type: "Postseason",
            date_time: "4/18/16",
            away_team_id: 15,
            home_team_id: 4,
            away_goals: 4,
            home_goals: 1,
            venue: "SeatGeek Stadium",
            venue_link: "/api/v1/venues/null"})
  end

  def test_it_exists_and_has_attributes
<<<<<<< HEAD
    assert_instance_of Game, @game
    assert_equal 2015030133, @game.game_id
    assert_equal 20152016, @game.season
    assert_equal "Postseason", @game.type
    assert_equal "4/18/16", @game.date_time
    assert_equal 15, @game.away_team_id
    assert_equal 4, @game.home_team_id
    assert_equal 4, @game.away_goals
    assert_equal 1, @game.home_goals
    assert_equal "SeatGeek Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

  def test_total_goals
    assert_equal 5, @game.total_goals
=======
    assert_instance_of Game, @game7
    assert_equal 2015030133, @game7.game_id
    assert_equal 20152016, @game7.season
    assert_equal "Postseason", @game7.type
    assert_equal "4/18/16", @game7.date_time
    assert_equal 15, @game7.away_team_id
    assert_equal 4, @game7.home_team_id
    assert_equal 4, @game7.away_goals
    assert_equal 1, @game7.home_goals
    assert_equal "SeatGeek Stadium", @game7.venue
    assert_equal "/api/v1/venues/null", @game7.venue_link
  end

  def test_total_score
    assert_equal 5, @game7.total_score
>>>>>>> 6d24697ad157641881b653c45f2260923b8c29fb
  end

  def test_winner
    assert_equal :visitor, @game.winner
  end

  def test_winning_team_score
    assert_equal 4, @game7.winning_team_score
    game1 = Game.new({
                  game_id: 2015030133,
                  season: 20152016,
                  type: "Postseason",
                  date_time: "4/18/16",
                  away_team_id: 15,
                  home_team_id: 4,
                  away_goals: 4,
                  home_goals: 10,
                  venue: "SeatGeek Stadium",
                  venue_link: "/api/v1/venues/null"
                })
    assert_equal 10, game1.winning_team_score
    game2 = Game.new({
                  game_id: 2015030133,
                  season: 20152016,
                  type: "Postseason",
                  date_time: "4/18/16",
                  away_team_id: 15,
                  home_team_id: 4,
                  away_goals: 1,
                  home_goals: 1,
                  venue: "SeatGeek Stadium",
                  venue_link: "/api/v1/venues/null"
                })
    assert_equal "Game tie: 1-1.", game2.winning_team_score
  end

  def test_losing_team_score
    assert_equal 1, @game7.losing_team_score
    game1 = Game.new({
                  game_id: 2015030133,
                  season: 20152016,
                  type: "Postseason",
                  date_time: "4/18/16",
                  away_team_id: 15,
                  home_team_id: 4,
                  away_goals: 4,
                  home_goals: 10,
                  venue: "SeatGeek Stadium",
                  venue_link: "/api/v1/venues/null"
                })
    assert_equal 4, game1.losing_team_score
    game2 = Game.new({
                  game_id: 2015030133,
                  season: 20152016,
                  type: "Postseason",
                  date_time: "4/18/16",
                  away_team_id: 15,
                  home_team_id: 4,
                  away_goals: 1,
                  home_goals: 1,
                  venue: "SeatGeek Stadium",
                  venue_link: "/api/v1/venues/null"
                })
    assert_equal "Game tie: 1-1.", game2.losing_team_score
  end
end
