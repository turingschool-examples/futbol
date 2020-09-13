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

  def test_can_find_most_accurate_team
    @game_team_manager.tracker.stubs(:get_season_game_ids).returns(["2016030171", "2016030172", "2016030173", "2016030174"])
    @game_team_manager.tracker.stubs(:get_team_name).returns("Real Salt Lake")
    assert_equal "Real Salt Lake", @game_team_manager.most_accurate_team("20162017")
  end

  def test_can_find_least_accurate_team
    @game_team_manager.tracker.stubs(:get_season_game_ids).returns(["2016030171", "2016030172", "2016030173", "2016030174"])
    @game_team_manager.tracker.stubs(:get_team_name).returns("Toronto FC")
    assert_equal "Toronto FC", @game_team_manager.least_accurate_team("20162017")
  end

  def test_can_find_team_with_most_tackles
    @game_team_manager.tracker.stubs(:get_season_game_ids).returns(["2016030171", "2016030172", "2016030173", "2016030174"])
    @game_team_manager.tracker.stubs(:get_team_name).returns("Toronto FC")
    assert_equal "Toronto FC", @game_team_manager.most_tackles("20162017")
  end

  def test_can_find_team_with_fewest_tackles
    @game_team_manager.tracker.stubs(:get_season_game_ids).returns(["2016030171", "2016030172", "2016030173", "2016030174"])
    @game_team_manager.tracker.stubs(:get_team_name).returns("Real Salt Lake")
    assert_equal "Real Salt Lake", @game_team_manager.fewest_tackles("20162017")
  end

  def test_can_find_winningest_coach
    game_ids = ["2012020225", "2012020577", "2012020510", "2012020511", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314"]
    assert_equal "Bruce Boudreau", @game_team_manager.find_winningest_coach(game_ids, "WIN")
  end
  
  def test_can_find_worst_coach
    game_ids = ["2016030171", "2016030172", "2016030173", "2016030174"]
    assert_equal "Glen Gulutzan", @game_team_manager.find_worst_coach(game_ids)
  end
end

