require './lib/game'
require './test/test_helper'
class GameTest < Minitest::Test
  def setup
    @game = Game.new({game_id: "2012030221", season: "20122013",
      type: "Postseason", date_time: "5/16/13", away_team_id: "3", home_team_id: "6",
      away_goals: "2", home_goals: "3", venue: "Toyota Stadium",
      venue_link: "/api/v1/venues/null"
      })
      Game.from_csv("./test/fixtures/games_truncated.csv")
      @games = Game.all
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_readable_attributes
    assert_equal 2012030221, @game.game_id
    assert_equal "20122013", @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/16/13", @game.date_time
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "Toyota Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

  def test_from_csv_creates_array_of_all_games
    assert_instance_of Array, @games
    assert_equal 30, @games.length
  end

  def test_objects_created_are_game_objects
    assert_instance_of Game, @games[0]
    assert_instance_of Game, @games[-1]
    assert_equal 2012030221, @games[0].game_id
    assert_equal "20122013", @games[0].season
    assert_equal "Postseason", @games[0].type
    assert_equal "5/16/13", @games[0].date_time
    assert_equal 3, @games[0].away_team_id
    assert_equal 6, @games[0].home_team_id
    assert_equal 2, @games[0].away_goals
    assert_equal 3, @games[0].home_goals
    assert_equal "Toyota Stadium", @games[0].venue
    assert_equal "/api/v1/venues/null", @games[0].venue_link
  end

  def test_it_can_return_all_scores
    all_scores_array = [5, 5, 3, 5, 4, 3, 5, 3, 1, 3, 3, 4, 2, 3, 3, 5, 5, 6, 4, 3, 5, 5, 6, 4, 3, 6, 4, 1, 6, 3]
    assert_equal all_scores_array, Game.all_scores
  end

  def test_it_can_return_highest_total_score
    assert_equal 6, Game.highest_total_score
  end

  def test_it_can_return_lowest_total_score
    assert_equal 1, Game.lowest_total_score
  end

  def test_it_can_return_percentage_home_wins
    assert_equal 50.0, Game.percentage_home_wins
  end

  def test_it_can_return_percentage_visitor_wins
    assert_equal 30.0, Game.percentage_visitor_wins
  end

  def test_it_can_return_percentage_ties
    assert_equal 20.0, Game.percentage_ties
  end

  def test_it_can_return_count_of_games_by_season
    expected_hash = {"20122013" => 21,
      "20132014" => 9
    }
    assert_equal expected_hash, Game.count_of_games_by_season
  end

  def test_it_can_return_average_goals_per_game
    assert_equal 3.93, Game.average_goals_per_game
  end
end
