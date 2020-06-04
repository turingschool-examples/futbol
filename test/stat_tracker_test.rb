require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_collection'
require './lib/team_collection'

class StatTrackerTest < MiniTest::Test
  class BasicTest < StatTrackerTest
    def setup
      game_path = './data/games_fixture.csv'
      team_path = './data/teams_fixture.csv'
      game_teams_path = './data/game_teams_fixture.csv'

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
      assert_instance_of Array, @stat_tracker.games
      assert_instance_of Array, @stat_tracker.teams
      assert_instance_of Array, @stat_tracker.game_teams
    end
  end

  class LeagueStatisticsTest < StatTrackerTest
    def setup
      game_path = './data/games.csv'
      team_path = './data/teams_fixture.csv'
      game_teams_path = './data/game_teams_fixture.csv'

      @locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      @stat_tracker = StatTracker.from_csv(@locations)
    end

    def test_it_can_do_count_of_teams
      assert_equal 7, @stat_tracker.count_of_teams
    end

    def test_it_can_determine_best_offense
      assert_equal "FC Dallas", @stat_tracker.best_offense
    end

    def test_it_can_determine_worst_offense
      assert_equal "Houston Dynamo", @stat_tracker.worst_offense
    end

    def test_it_can_determine_highest_scoring_visitor
      assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
    end

    def test_it_can_determine_lowest_scoring_visitor
      assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
    end

    def test_it_can_determine_highest_scoring_home_team
      assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
    end

    def test_it_can_determine_lowest_scoring_home_team
      assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
    end
  end
end
