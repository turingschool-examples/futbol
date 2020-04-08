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

    Game.from_csv("./test/fixtures/team_truncated.csv")
    game = Game.all_games[0]

     assert_equal 2012020242, game.game_id
     assert_equal "20122013", game.season
     assert_equal "Regular Season", game.type
     assert_equal "2/22/13", game.date_time
     assert_equal 3, game.away_team_id
     assert_equal 9, game.home_team_id
     assert_equal 2, game.away_goals
     assert_equal 2, game.home_goals
     assert_equal "Yankee Stadium", game.venue
     assert_equal "/api/v1/venues/null", game.venue_link
     assert_instance_of Game, game
  end

  def test_highest_total_score
      Game.from_csv("./test/fixtures/team_truncated.csv")

      assert_equal 7, Game.highest_total_score
  end

  def test_lowest_total_score
      Game.from_csv("./test/fixtures/team_truncated.csv")

      assert_equal 1, Game.lowest_total_score
  end

  def test_percentage_home_wins
    Game.from_csv("./test/fixtures/team_truncated.csv")

    assert_equal 0.5, Game.percentage_home_wins
  end

  def test_percentage_visitor_wins
    Game.from_csv("./test/fixtures/team_truncated.csv")

    assert_equal 0.39, Game.percentage_visitor_wins
  end

  def test_percentage_of_ties
    Game.from_csv("./test/fixtures/team_truncated.csv")

    assert_equal 0.11, Game.percentage_ties
  end

  def test_count_of_games_by_season
    Game.from_csv("./test/fixtures/team_truncated.csv")
    expected = {"20122013"=>52, "20132014"=>1, "20142015"=>60, "20162017"=>4}
    assert_equal expected, Game.count_of_games_by_season
  end

  def test_season_game_count
    Game.from_csv("./test/fixtures/team_truncated.csv")
    assert_equal 52, Game.season_game_count("20122013")
  end

  def test_average_goals_per_game
    Game.from_csv("./test/fixtures/team_truncated.csv")
    assert_equal 3.95, Game.average_goals_per_game
  end

  def test_goals_by_season
    Game.from_csv("./test/fixtures/team_truncated.csv")
    assert_equal 198, Game.goals_by_season("20122013")
  end

  def test_average_goals_by_season
    Game.from_csv("./test/fixtures/team_truncated.csv")
    expected = {"20122013"=>198, "20132014"=>7, "20142015"=>238, "20162017"=>19}
    assert_equal expected, Game.average_goals_by_season
  end



end
