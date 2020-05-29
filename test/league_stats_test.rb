require './test/helper_test'
require './lib/stat_tracker'
require './lib/game'
require './lib/game_collection'
require './lib/team'
require './lib/team_collection'
require './lib/game_team'
require './lib/game_team_collection'
require './lib/league_stats'

class LeagueStatsTest < Minitest::Test
  def setup
    games_collection = GameCollection.new("./test/fixtures/games_truncated.csv")
    teams_collection = TeamCollection.new("./data/teams.csv")
    game_teams_collection = GameTeamCollection.new("./test/fixtures/game_teams_truncated.csv")

    locations = {
      games_collection: games_collection,
      teams_collection: teams_collection,
      game_teams_collection: game_teams_collection
      }

    @league_stats = LeagueStats.new(locations)
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_it_has_attributes
    assert_instance_of GameCollection, @league_stats.games_collection
    assert_instance_of TeamCollection, @league_stats.teams_collection
    assert_instance_of GameTeamCollection, @league_stats.game_teams_collection
  end

  def test_it_can_count_teams
    assert_equal 32, @league_stats.count_of_teams
  end

  def test_it_can_find_unique_team_ids
    assert_equal 32, @league_stats.unique_team_ids.count
  end

  def test_it_can_sort_games_by_team_id
    
  end

  def test_it_can_find_best_offenseworst_offense
    assert_equal "Atlanta United", @league_stats.best_offense
  end

  def test_it_can_find_worst_offense
    assert_equal "Utah Royals", @league_stats.worst_offense
  end
end
