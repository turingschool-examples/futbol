require './lib/stat_tracker'
require './lib/game_collection'
require './lib/game_teams_collection'
require './lib/game_teams'
require './lib/game'
require './lib/team_collection'
require './lib/team'
require 'minitest/autorun'
require 'minitest/pride'

class StatTrackerTest < Minitest::Test

  def setup
    @locations = {
        games: './fixture_files/games_fixture.csv',
        teams: './data/teams.csv',
        game_teams: './fixture_files/game_teams_fixture.csv'
      }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_load_collections_of_various_data
    assert_instance_of GameTeamsCollection, @stat_tracker.gtc
    assert_equal GameTeams, @stat_tracker.gtc.game_teams.first.class
    assert_instance_of GameCollection, @stat_tracker.game_collection
    assert_equal Game, @stat_tracker.game_collection.games.first.class
    assert_instance_of TeamCollection, @stat_tracker.team_collection
    assert_equal Team, @stat_tracker.team_collection.teams.first.class
  end

  def test_it_can_return_the_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_it_can_return_the_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_it_can_return_percentage_ties
    assert_equal 0.09, @stat_tracker.percentage_ties
  end

  def test_it_can_return_count_of_games_by_season
    expected = {
      "20122013"=>5,
      "20162017"=>7,
      "20142015"=>4,
      "20152016"=>5,
      "20132014"=>5,
      "20172018"=>6
      }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_return_lowest_score

    assert_equal 2, @stat_tracker.lowest_total_score
  end

  def test_it_can_return_average_goals_per_game

    assert_equal 4.13, @stat_tracker.average_goals_per_game
  end

  def test_it_can_return_average_goals_by_season
    expected = {
      "20122013"=>3.8,
      "20162017"=>4.57,
      "20142015"=>4.5,
      "20152016"=>3.8,
      "20132014"=>4.4,
      "20172018"=>3.67
      }

    assert_equal expected, @stat_tracker.average_goals_by_season
  end

end
