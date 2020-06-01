require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

class StatTrackerTest < MiniTest::Test

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
  # class BasicTest < StatTrackerTest
  #   def setup
  #     game_path = './data/games.csv'
  #     team_path = './data/teams.csv'
  #     game_teams_path = './data/game_teams.csv'
  #
  #     @locations = {
  #       games: game_path,
  #       teams: team_path,
  #       game_teams: game_teams_path
  #     }
  #
  #     @stat_tracker = StatTracker.from_csv(@locations)
  #   end
  #
  #   def test_it_exists
  #     assert_instance_of StatTracker, @stat_tracker
  #   end
  #
  #   def test_it_has_attributes
  #     assert_equal './data/games.csv', @stat_tracker.games
  #     assert_equal './data/teams.csv', @stat_tracker.teams
  #     assert_equal './data/game_teams.csv', @stat_tracker.game_teams
  #   end
  # end

  class TeamStatisticsTest < StatTrackerTest

  end

  class SeasonStatisticsTest < StatTrackerTest

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
        assert_equal 6, @stat_tracker.count_of_teams
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
        skip
        assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
      end

    # highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
    # highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
    # lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
    # lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @stat_tracker.games
    assert_equal './data/teams_fixture.csv', @stat_tracker.teams
    assert_equal './data/game_teams_fixture.csv', @stat_tracker.game_teams
  end

  # class GameStatisticsTest < StatTrackerTest
  #   def setup
  #     game_path = './data/games_fixture.csv'
  #     team_path = './data/teams_fixture.csv'
  #     game_teams_path = './data/game_teams_fixture.csv'
  #
  #     @locations = {
  #       games: game_path,
  #       teams: team_path,
  #       game_teams: game_teams_path
  #     }
  #
  #     @stat_tracker = StatTracker.from_csv(@locations)
  #   end
  #
  #   def test_it_can_return_highest_total_score
  #     assert_equal 6, @stat_tracker.highest_total_score
  #   end
  #
  #   def test_it_can_return_lowest_total_score
  #     assert_equal 3, @stat_tracker.lowest_total_score
  #   end
  #
  #   def test_it_can_return_percentage_home_wins
  #     assert_equal 0.50, @stat_tracker.percentage_home_wins
  #   end
  #
  #   def test_it_can_return_percentage_visitor_wins
  #     assert_equal 0.25, @stat_tracker.percentage_visitor_wins
  #   end
  #
  #   def test_it_can_return_percentage_ties
  #     assert_equal 0.25, @stat_tracker.percentage_ties
  #   end
  #
  #   def test_it_can_return_count_of_games_by_season
  #     assert_equal ({"20122013" => 3, "20142015" => 1}), @stat_tracker.count_of_games_by_season
  #   end
  #
  #   def test_it_can_return_average_goals_per_game
  #     assert_equal 4.75, @stat_tracker.average_goals_per_game
  #   end
  #
  #   def test_it_can_return_average_goals_by_season
  #     assert_equal ({"20122013" => 4.33, "20142015" => 6}), @stat_tracker.average_goals_by_season
  #   end
  # end
end
