require_relative 'test_helper'

class SeasonStatistcsTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @instances = StatTracker.new
  end

  def test_it_exists
    stat_tracker = StatTracker.from_csv(@locations)
    season_statistics = SeasonStatistics.new

    assert_instance_of SeasonStatistics, season_statistics
  end

  

end
