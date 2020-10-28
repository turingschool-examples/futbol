require './lib/stat_tracker'
require './lib/team_statistics'
require './test/test_helper'

class TeamStatisticsTest < Minitest::Test
  def setup
    game_path = './data/game_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }

    @stat_tracker = StatTracker.from_csv(locations)
    @team_statistics = TeamStatistics.new(@stat_tracker)
    @team_id = '6'
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end

  # Helpers for team_info method
  def test_it_can_find_team_info_row
    expected = ["6", "6", "FC Dallas", "DAL", "/api/v1/teams/6"]
    assert_equal expected, @team_statistics.team_info_row(@team_id)
  end

  def test_it_can_list_team_info
    # 20,21,Toronto FC,TOR,BMO Field,/api/v1/teams/20
    expected = {
                team_id: '20',
                franchise_id: '21',
                team_name: 'Toronto FC',
                abbreviation: 'TOR',
                link: '/api/v1/teams/20'
              }
  assert_equal expected, @team_statistics.team_info('20')
  end

  # Helpers for best and worst season
  def test_it_can_find_total_games_per_team_id
    # use a stub here when not using dummy csv
    expected = [["2012030221", "6", "WIN", "3"],
                ["2012030222", "6", "WIN", "3"],
                ["2012030223", "6", "WIN", "2"],
                ["2012030224", "6", "WIN", "3"],
                ["2012030225", "6", "WIN", "3"],
                ["2012030311", "6", "WIN", "3"],
                ["2012030312", "6", "WIN", "4"],
                ["2012030313", "6", "WIN", "2"],
                ["2012030314", "6", "WIN", "1"],
                ["2013020021", "6", "WIN", "2"],
                ["2013020230", "6", "WIN", "2"],
                ["2013021187", "6", "TIE", "3"]]
    assert_equal expected, @team_statistics.total_games(@team_id)
  end

  def test_it_can_find_winning_games_per_team_id
    # use a stub here when not using dummy csv
    expected = [["2012030221", "6", "WIN", "3"],
                ["2012030222", "6", "WIN", "3"],
                ["2012030223", "6", "WIN", "2"],
                ["2012030224", "6", "WIN", "3"],
                ["2012030225", "6", "WIN", "3"],
                ["2012030311", "6", "WIN", "3"],
                ["2012030312", "6", "WIN", "4"],
                ["2012030313", "6", "WIN", "2"],
                ["2012030314", "6", "WIN", "1"],
                ["2013020021", "6", "WIN", "2"],
                ["2013020230", "6", "WIN", "2"]]
    assert_equal expected, @team_statistics.winning_games(@team_id)
  end

  def test_it_can_find_losing_games_per_team_id
    # use a stub here when not using dummy csv
    expected = [["2013021187", "6", "TIE", "3"]]
    assert_equal expected, @team_statistics.losing_games(@team_id)
  end

  def test_it_can_find_total_games_per_season
    # use a stub here when not using dummy csv
    expected = {
                "20122013"=>9.0,
                "20132014"=>3.0
              }
    assert_equal expected, @team_statistics.total_games_by_game_id(@team_id)
  end

  def test_it_can_find_winning_games_per_season
    skip
    assert_equal '5', @team_statistics.winning_games_by_game_id(@team_id)
  end

  def test_it_can_find_losing_games_per_season
    skip
    assert_equal '5', @team_statistics.losing_games_by_game_id(@team_id)
  end

  def test_it_can_find_highest_win_percentage_per_team_id
    skip
    assert_equal '5', @team_statistics.highest_win_percentage(@team_id)
  end

  def test_it_can_find_lowest_win_percentage_per_team_id
    skip
    assert_equal '5', @team_statistics.lowest_win_percentage(@team_id)
  end

  def test_it_can_find_best_season
    # Season with the highest win percentage for a team.
    assert_equal '20122013', @team_statistics.best_season(@team_id)
  end

  def test_it_can_find_worst_season
    # Season with the lowest win percentage for a team.
    assert_equal "20132014", @team_statistics.worst_season(@team_id)
  end

  def test_it_can_find_average_win_percentage
    # Average win percentage of all games for a team.
    assert_equal 91.67, @team_statistics.average_win_percentage(@team_id)
  end

  def test_it_can_find_highest_goals_by_team
    # Highest number of goals a particular team has scored in a single game.
    assert_equal 4, @team_statistics.most_goals_scored(@team_id)
  end

  def test_it_can_find_fewest_goals_by_team
    # Lowest numer of goals a particular team has scored in a single game.
    assert_equal 1, @team_statistics.fewest_goals_scored(@team_id)
  end

  # Helpers for favorite_oponent
  def test_it_can_find_opposing_team_total_games
    expected = {
                "3"=>["3", "3", "3", "3", "3"],
                "5"=>["5", "5", "5", "5"],
                "17"=>["17"],
                "13"=>["13"]
              }
    assert_equal expected, @team_statistics.opposing_team_total_games(@team_id)
  end

  def test_it_can_find_team_id_with_lowest_win_percentage
    assert_equal '5', @team_statistics.lowest_opposing_team(@team_id)
  end

  def test_it_can_find_favorite_oponent
    # Name of the opponent that has the lowest win percentage against the given team.
    assert_equal 'Sporting Kansas City', @team_statistics.favorite_oponent(@team_id)
  end
end
