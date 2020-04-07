require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game'


class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new({game_id: 123, season: "20122013", type: "Postseason",
          date_time: "6/5/13", away_team_id: 1, home_team_id: 1, away_goals: 1,
           home_goals: 1, venue: "Toyta", venue_link: "link" })
    assert_instance_of Game, game
  end

  def test_has_attributes
    game = Game.new({game_id: 123, season: "20122013", type: "Postseason",
      date_time: "6/5/13", away_team_id: 1, home_team_id: 1, away_goals: 1,
      home_goals: 1, venue: "Toyta", venue_link: "link" })

    assert_equal 123, game.game_id
    assert_equal "20122013", game.season
    assert_equal "Postseason", game.type
    assert_equal "6/5/13", game.date_time
    assert_equal 1, game.away_team_id
    assert_equal 1, game.home_team_id
    assert_equal 1, game.away_goals
    assert_equal 1, game.home_goals
    assert_equal "Toyta", game.venue
    assert_equal "link", game.venue_link
  end

  def test_it_has_teams
    Game.from_csv("./data/games.csv")
    game = Game.all_games[0]

     assert_equal 2012030221, game.game_id
     assert_equal "20122013", game.season
     assert_equal "Postseason", game.type
     assert_equal "5/16/13", game.date_time
     assert_equal 3, game.away_team_id
     assert_equal 6, game.home_team_id
     assert_equal 2, game.away_goals
     assert_equal 3, game.home_goals
     assert_equal "Toyota Stadium", game.venue
     assert_equal "/api/v1/venues/null", game.venue_link
     assert_instance_of Game, game
  end

  def test_highest_total_score
      Game.from_csv("./data/games.csv")

      assert_equal 11, Game.highest_total_score
  end

  def test_lowest_total_score
      Game.from_csv("./data/games.csv")

      assert_equal 0, Game.lowest_total_score
  end

  def test_percentage_home_wins
    Game.from_csv("./data/games.csv")

    assert_equal 0.44, Game.percentage_home_wins
  end

  def test_percentage_visitor_wins
    Game.from_csv("./data/games.csv")

    assert_equal 0.36, Game.percentage_visitor_wins
  end








end
