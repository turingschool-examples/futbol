require './test/test_helper'
require './lib/team_manager'
require './lib/stat_tracker'
require './lib/team'

class TeamManagerTest < Minitest::Test
  def setup
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.team_manager.count_of_teams
  end

  def test_teams_names_data_pull
    assert_equal 32, @stat_tracker.team_manager.team_data_by_id.count
  end
    @team_manager = TeamManager.new(@locations, @stat_tracker)
    @team_manager.generate_teams(@locations[:teams])
  end
end
