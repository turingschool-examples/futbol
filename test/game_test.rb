require_relative 'test_helper'
require_relative '../lib/game'

class GameTest < MiniTest::Test

  def setup
    stat_array = [{:team_id=>"3",
                   :HOA=>"away",
                   :Coach=>"John Tortorella",
                   :Shots=>"8",
                   :Tackles=>"44"},
                  {:team_id=>"6",
                   :HOA=>"home",
                   :Coach=>"Claude Julien",
                   :Shots=>"12",
                   :Tackles=>"51"}]

    @game = Game.new({
      :game_id     => 2012030221,
      :season      => 20122013,
      :type   => "Postseason",
      :date_time   => "5/16/13",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 2,
      :home_goals => 3,
      :venue => "Toyota Stadium",
      :venue_link => "/api/v1/venues/null"
    }, stat_array)

    @game2 = Game.new({
      :game_id     => 2012030222,
      :season      => 20122013,
      :type   => "Postseason",
      :date_time   => "5/16/13",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 5,
      :home_goals => 2,
      :venue => "Toyota Stadium",
      :venue_link => "/api/v1/venues/null"
    }, stat_array)

    @game3 = Game.new({
      :game_id     => 2012030222,
      :season      => 20122013,
      :type   => "Postseason",
      :date_time   => "5/16/13",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 2,
      :home_goals => 2,
      :venue => "Toyota Stadium",
      :venue_link => "/api/v1/venues/null"
    }, stat_array)

  end

  def teardown
    Game.reset_all
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game.id
    assert_equal 20122013, @game.season
  end

  def test_total_score
    assert_equal @game.total_score, 5
  end

  def test_score_difference
    assert_equal @game.score_difference, 1
  end

  def test_home_winner_teamid_can_be_returned
    assert_equal @game.winner, 6
  end

  def test_away_winner_team_id_can_be_returned
    assert_equal @game2.winner, 3
  end

  def test_nil_is_returned_if_game_is_tie
    assert_nil @game3.winner
  end

  def test_self_method_can_pull_all_games
    assert_equal 3, Game.all.length
    assert_instance_of Game, Game.all[0]
  end

  def test_winning_coach_can_be_returned
    assert_equal "Claude Julien", @game.winning_coach
  end
end
