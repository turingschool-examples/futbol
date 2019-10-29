require './test/test_helper'
require './lib/stat_tracker'
require './lib/team_module'

class TeamModuleTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams_fixture.csv'
    game_teams_path = './data/game_teams_fixture.csv'
    locations = { games: game_path, teams: team_path, game_teams: game_teams_path }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_team_info
    team = {Name: 'Atlanta United',
      Team_id: '1',
      Franchise_id: '23',
      Abbreviation: 'ATL',
      Link: '/api/v1/teams/1'
    }
    assert_equal team, @stat_tracker.team_info('Atlanta United')
  end

  def test_best_season
    assert_equal '20122013', @stat_tracker.best_season('Seattle Sounders FC')
  end

  def test_worst_season
    assert_equal '20122013', @stat_tracker.best_season('Seattle Sounders FC')
  end

  def test_avg_win_percentage
    assert_equal 0.43, @stat_tracker.average_win_percentage('Seattle Sounders FC')
  end

end
