require './test/test_helper'
require './lib/game_manager'

class GameManagerTest < Minitest::Test
  def setup
    @game_path = './fixtures/fixture_games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './fixtures/fixture_game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = mock('stat tracker object')
    @game_manager = GameManager.new(@locations, @stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameManager, @game_manager
  end

  def test_it_has_readable_attributes
    game_manager = mock('game manager object')
    game_1 = mock('game object 1')
    game_2 = mock('game object 2')
    game_3 = mock('game object 2')
    game_4 = mock('game object 2')
    game_5 = mock('game object 2')
    game_manager.stubs(:games).returns([game_1, game_2, game_3, game_4, game_5])
    assert_equal [game_1, game_2, game_3, game_4, game_5], game_manager.games
  end

  def test_it_can_find_highest_total_score
    assert_equal 9, @game_manager.highest_total_score
  end

  def test_it_can_find_lowest_score
    assert_equal 0, @game_manager.lowest_total_score
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.36, @game_manager.percentage_visitor_wins
    assert_equal 178, @game_manager.percentage_visitor_win_helper
  end

  def test_it_can_find_percentage_ties
    assert_equal 0.21, @game_manager.percentage_ties
    assert_equal 105, @game_manager.percentage_ties_helper
    assert_equal 0.43, @game_manager.percentage_home_wins
    assert_equal 213, @game_manager.percentage_home_win_helper
  end

  def test_it_can_count_games_by_season
    expected = { '20122013' => 92,
                 '20142015' => 109,
                 '20152016' => 118,
                 '20132014' => 75,
                 '20162017' => 74,
                 '20172018' => 28 }
    assert_equal expected, @game_manager.count_of_games_by_season
    assert_equal 496, @game_manager.count_of_games_by_season.values.sum
  end

  def test_it_can_find_average_goals_per_game
    assert_equal 4.21, @game_manager.average_goals_per_game
  end

  def test_it_can_find_average_goals_per_season
    expected = { '20122013' => 4.17,
                 '20142015' => 4.06,
                 '20152016' => 4.22,
                 '20132014' => 4.37,
                 '20162017' => 4.19,
                 '20172018' => 4.46 }
    assert_equal expected, @game_manager.average_goals_by_season
  end
end
