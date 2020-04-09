require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_stats'
require './lib/team'
require './lib/game'
require './lib/stat_tracker'


class StatTrackerTest < Minitest::Test

  # locations = {
  #   games: game_path,
  #   teams: team_path,
  #   game_teams: game_teams_path
  # }
  #
  # def setup
  #     @stat_tracker = StatTracker.from_csv({
  #       :teams     => "./data/teams.csv",
  #       :games => "./data/games.csv",
  #       :game_teams => "./data/game_teams.csv"
  #     })
  #   end
    def setup
        @stat_tracker = StatTracker.from_csv({
          :teams     => StatTracker.teams("./data/teams.csv"),
          :games => StatTracker.games("./data/games.csv"),
          :game_teams => StatTracker.game_stats("./data/game_teams.csv")
        })
      end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes


     assert_equal "ATL", @stat_tracker.team_path[0].abbreviation
    assert_equal 2012030221, @stat_tracker.game_path[0].game_id
    assert_equal 44.8, @stat_tracker.game_teams_path[0].faceoffwinpercentage

  end

  def test_it_has_teams
  expected = "Atlanta United"

    assert_equal expected, @stat_tracker.team_path[0].teamname
  end

  def test_it_has_games
    assert_equal 2012030222, @stat_tracker.game_path[1].game_id
  end

  def test_it_has_game_stats
     # require "pry";binding.pry
    assert_equal 2012030222, @stat_tracker.game_teams_path[2].game_id
  end

  def test_it_has_info

    expected = {:team_id=>3, :franchise_id=>10, :team_name=>"Houston Dynamo", :abbreviation=>"HOU", :link=>"/api/v1/teams/3"}
    assert_equal expected, @stat_tracker.team_info(3)
  end

  def test_best_season



    expected = "20152016"
    assert_equal expected, @stat_tracker.best_season(1)
  end

  def test_games_per_season

    expected = 87
    assert_equal expected, @stat_tracker.games_per_season(3, "20152016")
  end

  def test_teams_worst_season

    expected = "20132014"
    assert_equal expected, @stat_tracker.worst_season(2)
  end

  # def test_average_win_percentage
  #   @stat_tracker.game_stats(@stat_tracker.game_teams_path)
  #   expected = 0.0
  #   assert_equal expected, @stat_tracker.average_win_percentage(5)
  #
  # end

  def test_total_games_played


  end

  def test_highest_total_score

    expected = 0
    assert_equal expected, @stat_tracker.highest_total_score(all_games)

  end
end
