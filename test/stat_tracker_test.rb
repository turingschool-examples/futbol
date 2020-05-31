
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

  class BasicTest < StatTrackerTest
    def setup
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
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

  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @stat_tracker.games
    assert_instance_of TeamCollection, @stat_tracker.teams
    assert_equal './data/game_teams_fixture.csv', @stat_tracker.game_teams
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
      skip
      assert_equal 4.75, @stat_tracker.average_goals_per_game
    end

    def test_it_can_return_average_goals_by_season
      skip
      assert_equal ({"20122013" => 4.33, "20142015" => 6}), @stat_tracker.average_goals_by_season
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

    def test_it_returns_total_games_per_team
      assert_equal 4, @stat_tracker.total_games_per_team("3")
    end

    # def test_it_can_return_team_games_per_season
    #   assert_equal ({"20122013" => 4.33, "20142015" => 6}), @stat_tracker.total_games_per_team_per_season(3)
    # end

    def test_it_can_return_best_season
      skip
      assert_equal 20122013, @stat_tracker.best_season
    end

  end
end


end
