require './test/helper_test'
require './lib/stat_tracker'
require './lib/team'
require './lib/game_team'
require './lib/league_stats'

class LeagueStatsTest < Minitest::Test
  def setup
    @locations = {
      teams_collection: './data/teams.csv',
      game_teams_collection: './test/fixtures/game_teams_truncated.csv'
      }

    @stat_tracker = StatTracker.from_csv(@locations)
    @league_stats = LeagueStats.new(@locations)
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_it_has_attributes
    assert_instance_of TeamCollection, @league_stats.teams_collection
    assert_instance_of GameTeamCollection, @league_stats.game_teams_collection
  end
end
