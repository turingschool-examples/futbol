require_relative 'test_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/games'
require_relative '../lib/teams'
require_relative '../lib/game_teams'



class StatTrackerTest < MiniTest::Test

  def setup
    @stat_tracker = StatTracker.new("game objects","team objects","game team objects")
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_attributes
    assert_equal "game objects", @stat_tracker.game_objs
    assert_equal "team objects", @stat_tracker.team_objs
    assert_equal "game team objects", @stat_tracker.game_teams_objs
  end

  def test_from_csv
    locations = { games: './data/dummy_games.csv', teams: './data/dummy_teams.csv', game_teams: './data/dummy_game_teams.csv' }
    stat_tracker_2 = StatTracker.from_csv(locations)
    assert_instance_of StatTracker, stat_tracker_2
    assert_instance_of Game, stat_tracker_2.game_objs[0]
    assert_instance_of Game, stat_tracker_2.game_objs[1]
    assert_instance_of Game, stat_tracker_2.game_objs[2]
    assert_instance_of Game, stat_tracker_2.game_objs[3]
    assert_instance_of Team, stat_tracker_2.team_objs[0]
    assert_instance_of Team, stat_tracker_2.team_objs[1]
    assert_instance_of Team, stat_tracker_2.team_objs[2]
    assert_instance_of Team, stat_tracker_2.team_objs[3]
    assert_instance_of GameTeams, stat_tracker_2.game_teams_objs[0]
    assert_instance_of GameTeams, stat_tracker_2.game_teams_objs[1]
    assert_instance_of GameTeams, stat_tracker_2.game_teams_objs[2]
    assert_instance_of GameTeams, stat_tracker_2.game_teams_objs[3]
    assert_equal 4, stat_tracker_2.game_objs.length
    assert_equal 4, stat_tracker_2.team_objs.length
    assert_equal 4, stat_tracker_2.game_teams_objs.length
  end

end
