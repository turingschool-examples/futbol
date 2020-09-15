require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'mocha/minitest'
require 'Pry'
require './lib/game'
require './lib/game_manager'

class GameManagerTest < MiniTest::Test
  def setup
    game_path = './data/games_dummy.csv'
    @game_manager = GameManager.new(game_path, "tracker")
  end

  def test_it_exists
    assert_instance_of GameManager, @game_manager
  end

  def test_create_underscore_games
    @game_manager.games.each do |game|
      assert_instance_of Game, game
    end
  end

  def test_game_manager_can_calculate_highest_total_score
    assert_equal 7, @game_manager.highest_total_score
  end

  def test_game_manager_can_calculate_lowest_total_score
    assert_equal 1, @game_manager.lowest_total_score
  end

  def test_game_manager_can_calculate_percentage_home_wins
   assert_equal 0.53, @game_manager.percentage_home_wins
  end

  def test_game_manager_can_calculate_percentage_visitor_wins
    assert_equal 0.41, @game_manager.percentage_visitor_wins
  end

  def test_game_manager_can_calculate_percentage_ties
    assert_equal 0.06, @game_manager.percentage_ties
  end

  def test_it_can_average_goals_by_season
    assert_equal ({'20132014' => 4.0, '20122013' => 4.36, "20162017" => 4.75}), @game_manager.average_goals_by_season
  end

  def test_it_finds_highest_scoring_visitor
    @game_manager.tracker.stubs(:get_team_name).returns("FC Cincinnati")
    assert_equal "FC Cincinnati", @game_manager.highest_scoring_visitor
  end

  def test_game_manager_finds_highest_scoring_home_team
    @game_manager.tracker.stubs(:get_team_name).returns("Chicago Fire")
    assert_equal "Chicago Fire", @game_manager.highest_scoring_home_team
  end

  def test_can_find_lowest_scoring_visitor
    @game_manager.tracker.stubs(:get_team_name).returns("Atlanta United")
    assert_equal "Atlanta United", @game_manager.lowest_scoring_visitor
  end

  def test_game_manager_can_get_ids_of_games_in_season
    assert_equal ["2013020674", "2013020177"], @game_manager.get_season_game_ids("20132014")
  end

  def test_game_manager_can_count_games_by_season
    assert_equal ({"20132014"=>2, "20122013"=>11, "20162017" => 4}), @game_manager.count_of_games_by_season
  end

  def test_game_manager_can_average_goals_per_game
    assert_equal 4.41, @game_manager.average_goals_per_game
  end

  def test_can_find_lowest_scoring_home_team
    @game_manager.tracker.stubs(:get_team_name).returns("Atlanta United")
    assert_equal "Atlanta United", @game_manager.lowest_scoring_home_team
  end

  def test_can_get_team_with_best_season
    assert_equal "20132014", @game_manager.best_season("24")
  end

  def test_can_get_worst_season_for_team
    assert_equal "20122013", @game_manager.worst_season("24")
  end

  def test_it_can_show_how_many_wins_per_season
    assert_equal 3, @game_manager.wins_per_season("24")
  end
end
