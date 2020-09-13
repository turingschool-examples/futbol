require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require 'Pry'
require './lib/game_team'
require './lib/game_team_manager'

class GameTeamManagerTest < MiniTest::Test
  def setup
    game_team_path = './data/game_teams_dummy.csv'
    @game_team_manager = GameTeamManager.new(game_team_path, "tracker")
  end
  def test_it_exists
    assert_instance_of GameTeamManager, @game_team_manager
  end

  def test_create_underscore_game_teams
    @game_team_manager.game_teams.each do |game_team|
      assert_instance_of GameTeam, game_team
    end
  end

  def test_it_can_find_average_win_percentage
    assert_equal 0.88, @game_team_manager.average_win_percentage("6")
  end

  def test_it_can_get_team_with_best_offense
    @game_team_manager.tracker.stubs(:get_team_name).returns("Real Salt Lake")
    assert_equal "Real Salt Lake", @game_team_manager.best_offense
  end

  def test_it_can_get_team_with_worst_offense
    @game_team_manager.tracker.stubs(:get_team_name).returns("Atlanta United")
    assert_equal "Atlanta United", @game_team_manager.worst_offense
  end

  def test_it_can_find_all_game_teams #### How do we test for this lol
    skip
    assert_equal "Real Salt Lake", @game_team_manager.find_all_teams("24")
  end

  def test_it_can_find_most_goals_scored ### Need to stub
    assert_equal 4, @game_team_manager.most_goals_scored("6")
  end

  def test_it_can_find_fewest_goals_scored ### Need to stub
    assert_equal 0, @game_team_manager.fewest_goals_scored("5")
  end

  def test_it_can_find_favorite_opponent_id
    assert_equal "3", @game_team_manager.favorite_opponent_id("6")
  end

  def test_it_can_find_rival_id
    assert_equal "6", @game_team_manager.rival_id("3")
  end

  def test_it_can_find_game_ids
    assert_equal ["2012030221", "2012030222", "2012020577", "2012030224", "2012030311", "2012030312", "2012030313", "2012030314"], @game_team_manager.find_game_ids("6")
  end


end
