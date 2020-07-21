require "./test/test_helper"
# require 'minitest/autorun'
# require 'minitest/pride'
# require "./lib/stat_tracker"
# require "./lib/games"
# require "./lib/game_teams"
# require "./lib/teams"
# require "pry"


class StatTrackerTest < MiniTest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exist
    assert_instance_of StatTracker, @stat_tracker
  end

   def test_can_find_percentage_tie
     assert_equal 0.20, @stat_tracker.percentage_tie
   end

   def test_count_games_by_season
     expected = {"20122013" => 806,
                 "20162017" => 1317,
                 "20142015" => 1319,
                 "20152016" => 1321,
                 "20132014" => 1323,
                 "20172018" => 1355
                  }
     assert_equal expected, @stat_tracker.count_of_games_by_season
   end

   def test_count_of_teams
     assert_equal 32, @stat_tracker.count_of_teams
   end

   def test_highest_scoring_home_team
     assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
   end
end

# highest_scoring_home_team	Name of the team with the highest
# average score per game across all seasons when they are home.
# String
#
#count_of_teams	Total number of teams in the data.
#
# lowest_scoring_home_team	Name of the team with the lowest average
# score per game across all seasons when they are at home.	String
