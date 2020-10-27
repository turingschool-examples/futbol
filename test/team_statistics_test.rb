require './lib/stat_tracker'
require './lib/team_statistics'
require './test/test_helper'

class TeamStatisticsTest < Minitest::Test
  def setup
    game_path = './data/game_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }

    @stat_tracker = StatTracker.from_csv(locations)
    @team_statistics = TeamStatistics.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end
end
