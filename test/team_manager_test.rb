require './test/test_helper'
require './lib/team_manager'
require './lib/stat_tracker'
require './lib/team'

class TeamManagerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = mock('mock stat tracker')
    @team_manager = TeamManager.new(@locations, @stat_tracker)
  end

  def test_count_of_teams
    assert_equal 32, @team_manager.count_of_teams
  end

  def test_teams_names_data_pull
    # @team_manager = TeamManager.new(@locations, @team_manager)
    @team_manager.generate_teams(@locations[:teams])
    assert_equal 32, @team_manager.team_data_by_id.count
  end
end
