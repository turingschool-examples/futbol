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

  def test_it_can_fetch_game_team_info
    locations =  {
      games: './fixtures/fixture_games.csv',
      teams: './fixtures/teams_init_test.csv',
      game_teams: './fixtures/fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.new(locations)
    info16 = stat_tracker.game_teams_manager.game_teams[19].game_team_info
    info17 = stat_tracker.game_teams_manager.game_teams[18].game_team_info
    expected = {
      '16' => info16,
      '17' => info17
    }

    assert_equal expected, stat_tracker.game_team_info('2012030231')
  end

  def test_it_can_fetch_game_info
    locations =  {
      games: './fixtures/fixture_games.csv',
      teams: './fixtures/teams_init_test.csv',
      game_teams: './fixtures/fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.new(locations)
    expected = {
      season_id: '20142015',
      game_id: '2014021174',
      home_team_id: '3',
      away_team_id: '1',
      home_goals: 4,
      away_goals: 1
    }

    assert_equal expected, stat_tracker.game_info('2014021174')
  end

  def test_it_can_calculate_average_win_percentage_for_a_team
    locations =  {
      games: './fixtures/team_stats_fixture_games.csv',
      teams: './data/teams.csv',
      game_teams: './fixtures/team_stats_fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.new(locations)

    assert_equal 0.56, stat_tracker.average_win_percentage('26')
    assert_equal 0.45, stat_tracker.average_win_percentage('24')
  end

  def test_it_can_find_a_teams_favorite_opponent
    locations =  {
      games: './fixtures/team_stats_fixture_games.csv',
      teams: './data/teams.csv',
      game_teams: './fixtures/team_stats_fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.new(locations)

    assert_equal 'Chicago Fire', stat_tracker.favorite_opponent('24')
  end

  def test_it_can_find_a_teams_rival
    locations =  {
      games: './fixtures/team_stats_fixture_games.csv',
      teams: './data/teams.csv',
      game_teams: './fixtures/team_stats_fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.new(locations)

    assert_equal 'North Carolina Courage', stat_tracker.rival('24')
  end

  def test_it_can_find_most_goals_scored_by_team
    locations =  {
      games: './fixtures/team_stats_fixture_games.csv',
      teams: './data/teams.csv',
      game_teams: './fixtures/team_stats_fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.new(locations)

    assert_equal 4, stat_tracker.most_goals_scored('24')
  end

  def test_it_can_find_fewest_goals_scored_by_team
    locations =  {
      games: './fixtures/team_stats_fixture_games.csv',
      teams: './data/teams.csv',
      game_teams: './fixtures/team_stats_fixture_game_teams.csv'
    }
    stat_tracker = StatTracker.new(locations)

    assert_equal 0, stat_tracker.fewest_goals_scored('24')
  end
end
