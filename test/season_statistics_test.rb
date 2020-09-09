require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_statistics'
require './lib/season_statistics'

class SeasonStatisticsTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @season_statistics = SeasonStatistics.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

end
