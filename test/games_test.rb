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
    assert_equal 6, @game.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 1, @game.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    assert_equal 5, @game.biggest_blowout
  end

  def test_it_can_calculate_percentage_home_wins
    assert_equal 60.0, @game.percentage_home_wins
  end


end
