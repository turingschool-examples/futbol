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
    assert_equal "game objects", @stat_tracker.games
    assert_equal "team objects", @stat_tracker.teams
    assert_equal "game team objects", @stat_tracker.game_teams
  end

  def test_from_csv
    locations = { games: './data/games.csv', teams: './data/teams.csv', game_teams: './data/game_teams.csv' }
    stat_tracker_2 = StatTracker.from_csv(locations)
    assert_instance_of StatTracker, stat_tracker_2
    assert_instance_of Game, stat_tracker_2.games.values.sample
    assert_instance_of Team, stat_tracker_2.teams.values.sample
    assert_instance_of GameTeams, stat_tracker_2.game_teams.values.sample[0]
    assert_equal 7441, stat_tracker_2.games.length
    assert_equal 32, stat_tracker_2.teams.length
    count = 0
    stat_tracker_2.game_teams.each do |id, array|
      array.each do |obj|
        count += 1
      end
    end
    assert_equal 14882, count
  end
end
