require 'minitest/autorun'
require 'minitest/pride'
require "./lib/stat_tracker"
require "./lib/games"
require "./lib/game_teams"
require "./lib/teams"
require "pry"


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
  #
  # def test_it_exist
  #   assert_instance_of StatTracker, @stat_tracker
  # end

   def test_can_find_percentage_tie
     assert_equal 0.20, @stat_tracker.percentage_tie
   end

   def test_count_games_by_season
     binding.pry
     expected = {"20122013" => 806,
                 "20162017" => 1317,
                 "20142015" => 1319,
                 "20152016" => 1321,
                 "20132014" => 1323,
                 "20172018" => 1355
                  }
     assert_equal expected, @stat_tracker.count_of_games_by_season
   end


end

# game.find {|game| game["date_time"] == "5/16/13"; return game["venue"] }
