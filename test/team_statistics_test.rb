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
    assert_equal '20122013', @team_statistics.worst_season(@team_id)
  end
end
