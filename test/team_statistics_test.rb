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

  def test_it_can_find_favorite_oponent
    # Name of the opponent that has the lowest win percentage against the given team.
    assert_equal 'Sporting Kansas City', @team_statistics.favorite_oponent(@team_id)
  end

  def test_it_can_find_favorite_oponent
    # Name of the opponent that has the lowest win percentage against the given team.
    assert_equal 'Sporting Kansas City', @team_statistics.favorite_oponent(@team_id)
  end
end
