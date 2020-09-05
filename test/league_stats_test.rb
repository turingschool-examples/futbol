require './test/test_helper'
require './lib/league_stats'

class TeamStatsTest <Minitest::Test

  def setup
    game_path = './fixtures/_game_teams.csv'
    team_path = './data/teams.csv'
    game_teams_path = './fixtures/games.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_gather_team_info
    @stat_tracker.extend(LeagueStats)
    assert_equal 23, stat_tracker.count_of_teams
  end
end
