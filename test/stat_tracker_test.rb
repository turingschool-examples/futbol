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

    def test_it_can_do_count_of_teams
      assert_equal 32, @stat_tracker.count_of_teams
    end
  end
  # count_of_teams	Total number of teams in the data.	Integer
  # best_offense	Name of the team with the highest average number of goals scored per game across all seasons.	String
  # worst_offense	Name of the team with the lowest average number of goals scored per game across all seasons.	String
  # highest_scoring_visitor	Name of the team with the highest average score per game across all seasons when they are away.	String
  # highest_scoring_home_team	Name of the team with the highest average score per game across all seasons when they are home.	String
  # lowest_scoring_visitor	Name of the team with the lowest average score per game across all seasons when they are a visitor.	String
  # lowest_scoring_home_team	Name of the team with the lowest average score per game across all seasons when they are at home.	String
  class GameStatisticsTest < StatTrackerTest

  end

end
