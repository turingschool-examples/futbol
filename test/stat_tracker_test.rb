require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test
  class BasicTest < StatTrackerTest
    def setup
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      @locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      @stat_tracker = StatTracker.from_csv(@locations)
    end

    def test_it_exists
      assert_instance_of StatTracker, @stat_tracker
    end

    def test_it_has_attributes
      assert_equal './data/games.csv', @stat_tracker.games
      assert_equal './data/teams.csv', @stat_tracker.teams
      assert_equal './data/game_teams.csv', @stat_tracker.game_teams
    end
  end

  class TeamStatisticsTest < StatTrackerTest

  end

  class SeasonStatisticsTest < StatTrackerTest

  end

  class LeagueStatisticsTest < StatTrackerTest
  end

  class GameStatisticsTest < StatTrackerTest

  end

end
