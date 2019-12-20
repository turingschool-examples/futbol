require './test/test_helper'
require './lib/games'

class GamesTest < Minitest::Test

  def setup
    @new_game = Games.new({
      game_id: 2012030221,
      season: 20122013,
      type: "Postseason",
      date_time: "5/16/13",
      away_team_id: 3,
      home_team_id: 6,
      away_goals: 2,
      home_goals: 3,
      venue: "Toyota Stadium"
    })

    Games.from_csv('./data/games_dummy.csv')

    @game = Games.all[0]
  end

  def test_it_exists
    assert_instance_of Games, @game
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game.game_id
    assert_equal 20122013, @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/16/13", @game.date_time
    assert_equal 3, @game.away_team_id
    assert_equal 6, @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "Toyota Stadium", @game.venue
  end

  def test_it_can_calculate_highest_total_score

    assert_equal 6, Games.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 1, Games.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 5, Games.biggest_blowout
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 0.43, Games.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    assert_equal 0.48, Games.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    assert_equal 0.09, Games.percentage_ties
  end

  def test_it_can_count_games_by_season
    assert_equal ({20122013 => 4, 20142015 => 11, 20152016 => 1, 20172018 => 7}), Games.count_of_games_by_season
  end

  def test_it_calculate_average_goals_per_game
    assert_equal 4.17, Games.average_goals_per_game
  end

  def test_it_calculate_average_goals_per_season
    assert_equal ({20122013 => 4.5, 20142015 => 4.06, 20152016 => 3.0, 20172018 => 4.27}), Games.average_goals_by_season
  end
end
