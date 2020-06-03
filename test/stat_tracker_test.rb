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
      assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
    end

    def test_it_can_determine_highest_scoring_home_team
      assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
    end

    def test_it_can_determine_lowest_scoring_home_team
      assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
    end
  end

  class GameStatisticsTest < StatTrackerTest
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

    def test_it_can_return_highest_total_score
      assert_equal 6, @stat_tracker.highest_total_score
    end

    def test_it_can_return_lowest_total_score
      assert_equal 3, @stat_tracker.lowest_total_score
    end

    def test_it_can_return_percentage_home_wins
      assert_equal 0.50, @stat_tracker.percentage_home_wins
    end

    def test_it_can_return_percentage_visitor_wins
      assert_equal 0.25, @stat_tracker.percentage_visitor_wins
    end

    def test_it_can_return_percentage_ties
      assert_equal 0.25, @stat_tracker.percentage_ties
    end

    def test_it_can_return_count_of_games_by_season
      assert_equal ({"20122013" => 3, "20142015" => 1}), @stat_tracker.count_of_games_by_season
    end

    def test_it_can_return_average_goals_per_game
      assert_equal 5, @stat_tracker.average_goals_per_game
    end

    def test_it_can_return_average_goals_by_season
      assert_equal ({"20122013"=>4.67, "20142015"=>6.0, "20172018"=>4.0}), @stat_tracker.average_goals_by_season
    end
  end


  class TeamStatisticsTest < StatTrackerTest
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

    def test_it_returns_team

      assert @stat_tracker.team_info("1")
    end

    def test_it_returns_total_games
      assert_equal 5, @stat_tracker.total_games("6")
    end

    def test_it_counts_wins
      assert_equal 3, @stat_tracker.count_wins("6", 4)
    end

    def test_it_returns_total_wins_per_season
      assert_equal ({"20122013" => 3}), @stat_tracker.total_team_wins_per_season("6")
    end

    def test_it_returns_win_percentage_per_season
      assert_equal ({"20122013"=>1.0, "20142015"=>0.0, "20172018"=>0.0}), @stat_tracker.percentage_wins_per_season("6")
    end

    def test_it_can_return_best_season
      assert_equal "20122013", @stat_tracker.best_season("6")
    end

    def test_it_can_return_worst_season
      assert_equal "20172018", @stat_tracker.worst_season("6")
    end

    def test_it_returns_average_win_percentage
      assert_equal 0.6, @stat_tracker.average_win_percentage("6")
    end

    def test_it_returns_most_goals_scored
      assert_equal 3, @stat_tracker.most_goals_scored("6")
    end

    def test_it_returns_fewest_goals_scored
      assert_equal 1, @stat_tracker.fewest_goals_scored("6")
    end

    def test_it_returns_favorite_opponent
      assert_equal "Houston Dynamo", @stat_tracker.favorite_opponent("6")
    end

    def test_it_can_return_rival
      assert_equal "North Carolina Courage", @stat_tracker.rival("6")
    end
  end
end
