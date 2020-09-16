require_relative 'test_helper'

class TeamTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @hash = {
       team_id: '1',
       franchiseid: '23',
       teamname: 'Atlanta United',
       abbreviation: 'ATL',
       link: '/api/v1/teams/1'
      }
    @tracker = StatTracker.from_csv(locations)
    @game_stats   = GameStats.new(@tracker)
    @team         = Team.new(@hash)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end
end