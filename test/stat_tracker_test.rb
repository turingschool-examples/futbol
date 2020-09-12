require './test/test_helper'
require './lib/stat_tracker'
require 'pry'



class TestStatTracker <Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_stat_tracker_can_pull_file_locations

    assert_equal 7441, @stat_tracker.games.length
    assert_equal 32, @stat_tracker.teams.length
    assert_equal 14882, @stat_tracker.game_teams.length
  end

  def test_it_has_data

    assert_equal "20122013", @stat_tracker.games[5].season
    assert_equal "Columbus Crew SC", @stat_tracker.teams[31].team_name
    assert_equal 41.5, @stat_tracker.game_teams[14028].faceOffWinPercentage
  end

  def test_it_can_get_team_data
    locations =  {
      games: './fixtures/fixture_games.csv',
      teams: './fixtures/teams_init_test.csv',
      game_teams: './fixtures/fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.from_csv(locations)
    expected ={
           "team_id" => "t1",
      "franchise_id" => "f1",
         "team_name" => "n1",
      "abbreviation" => "a1",
              "link" => "l1"
    }
    actual = stat_tracker.team_info('t1')

    assert_equal expected, actual
  end

  def test_it_can_fetch_game_ids_for_a_team
    locations =  {
      games: './fixtures/fixture_games.csv',
      teams: './fixtures/teams_init_test.csv',
      game_teams: './fixtures/fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.new(locations)
    expected = ['2012030231', '2012030232', '2012030233', '2012030234', '2012030235', '2014020550']

    assert_equal expected, stat_tracker.game_ids_by_team('17')
  end
end
