require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'mocha/minitest'

class StatTrackerTest < Minitest::Test

  def setup
  game_path       = './data/games.csv'
  team_path       = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }

  @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_game_ids_per_season
     expected = {"20122013"=> ["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314", "2012030231", "2012030232", "2012030233", "2012030234", "2012030235", "2012030236", "2012030237", "2012030121", "2012030122", "2012030123", "2012030124", "2012030125", "2012030151", "2012030152", "2012030153", "2012030154", "2012030155", "2012030181", "2012030182", "2012030183", "2012030184", "2012030185", "2012030186", "2012030161", "2012030162", "2012030163", "2012030164", "2012030165", "2012030166", "2012030167", "2012030111", "2012030112", "2012030113", "2012030114", "2012030115", "2012030116", "2012030131", "2012030132", "2012030133", "2012030134", "2012030135", "2012030136", "2012030137", "2012030321", "2012030322"], "20162017"=>["2016030165"], "20152016"=>["2015030311"]}
     assert_equal 6, @stat_tracker.game_ids_per_season.count
  end

  def test_find_team
    assert_equal "Houston Dynamo", @stat_tracker.find_team("3")
  end
end
