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
    @team_id = '3'
  end

  def test_it_exists
    assert_instance_of TeamStatistics, @team_statistics
  end

 # Team Statistics Method Tests
  def test_it_can_list_team_info
    expected = {
                team_id: '20',
                franchise_id: '21',
                team_name: 'Toronto FC',
                abbreviation: 'TOR',
                link: '/api/v1/teams/20'
              }
  assert_equal expected, @team_statistics.team_info('20')
  end

  # def test_it_can_find_best_season
  # # Season with the highest win percentage for a team.
  #   assert_equal '20142015', @team_statistics.best_season(@team_id)
  # end

  # def test_it_can_find_worst_season
  # # Season with the lowest win percentage for a team.
  #   assert_equal "20142015", @team_statistics.worst_season(@team_id)
  # end

  def test_it_can_find_average_win_percentage
  # Average win percentage of all games for a team.
    assert_equal 37.04, @team_statistics.average_win_percentage(@team_id)
  end

  def test_it_can_find_highest_goals_by_team
  # Highest number of goals a particular team has scored in a single game.
    assert_equal 5, @team_statistics.most_goals_scored(@team_id)
  end

  def test_it_can_find_fewest_goals_by_team
  # Lowest numer of goals a particular team has scored in a single game.
    assert_equal 0, @team_statistics.fewest_goals_scored(@team_id)
  end

  def test_it_can_find_favorite_oponent
  # Name of the opponent that has the lowest win percentage against the given team.
    assert_equal 'Portland Timbers', @team_statistics.favorite_oponent(@team_id)
  end

  def test_it_can_find_rival
  # Name of the opponent that has the highest win percentage against the given team
    assert_equal 'Portland Timbers', @team_statistics.rival(@team_id)
  end

  # Helper method tests
  def test_it_can_find_team_info_row
    expected = ["3", "10", "Houston Dynamo", "HOU", "/api/v1/teams/3"]
    assert_equal expected, @team_statistics.team_info_row(@team_id)
  end

  def test_it_can_find_total_games_per_team_id
    assert_equal 27, @team_statistics.total_games(@team_id).count
  end

  def test_it_can_find_winning_games_per_team_id
    assert_equal 10, @team_statistics.winning_games(@team_id).count
  end

  def test_it_can_find_losing_games_per_team_id
    assert_equal 17, @team_statistics.losing_games(@team_id).count
  end

  def test_it_can_find_total_games_per_season
    assert_equal 3, @team_statistics.total_games_by_game_id(@team_id).count
  end

  def test_it_can_find_winning_games_per_season
    assert_equal 2, @team_statistics.winning_games_by_game_id(@team_id).count
  end

  def test_it_can_find_losing_games_per_season
    assert_equal 3, @team_statistics.losing_games_by_game_id(@team_id).count
  end

  def test_it_can_find_team_id_for_highest_win_percentage
    assert_equal '15', @team_statistics.highest_win_percentage(@team_id)
  end

  def test_it_can_find_team_id_for_lowest_win_percentage
    assert_equal '15', @team_statistics.lowest_win_percentage(@team_id)
  end

  def test_it_can_list_total_games_played_with_opposing_team
    expected = {
                "15"=>["15", "15"],
                "5"=>["5", "5", "5", "5", "5"],
                "14"=>["14", "14", "14"]
              }
    assert_equal expected, @team_statistics.total_opposing_team_games(@team_id)
  end

  def test_it_can_list_number_of_games_lost_per_opposing_team
    expected = {
                "15"=>2,
                "5"=>5,
                "14"=>3
              }
    assert_equal expected, @team_statistics.lowest_opposing_team(@team_id)
  end

  def test_it_can_list_number_of_games_won_per_opposing_team
    expected = {
                "6"=>5,
                "15"=>5,
                "5"=>4,
                "14"=>3
              }
    assert_equal expected, @team_statistics.highest_opposing_team(@team_id)
  end
end
