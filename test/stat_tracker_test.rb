require_relative 'test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }

    @stat_tracker = StatTracker.new(@locations)
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
   assert_instance_of StatTracker, @stat_tracker
  end

  def test_from_csv
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    @game_manager = GameManager.new(@locations[:games], self)
    @game_teams_manager = GameTeamsManager.new(@locations[:game_teams], self)
    @team_manager = TeamManager.new(@locations[:teams], self)

    assert_instance_of GameManager, @stat_tracker.game_manager
    assert_instance_of TeamManager, @stat_tracker.team_manager
    assert_instance_of GameTeamsManager, @stat_tracker.game_teams_manager
  end
end
