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
    assert_equal 16, @league_stats.games_sorted_by_team_id(52).count
    assert_equal 7, @league_stats.games_sorted_by_team_id(22).count
  end

  def test_it_can_total_goals_by_team_id
    assert_equal 33, @league_stats.total_goals_by_team_id(5)
    assert_equal 12, @league_stats.total_goals_by_team_id(24)
  end

  def test_it_can_average_goals_by_team_id
    assert_equal 1.86, @league_stats.average_goals_by_team_id(1)
    assert_equal 1.93, @league_stats.average_goals_by_team_id(18)
  end

  def test_it_can_find_best_offense
    assert_equal "DC United", @league_stats.best_offense
  end

  def test_it_can_find_worst_offense
    assert_equal "Sky Blue FC", @league_stats.worst_offense
  end

  def test_it_has_highest_scoring_visitor
    assert_equal "San Jose Earthquakes", @league_stats.highest_scoring_visitor
  end

  def test_it_has_highest_scoring_home_team
    assert_equal "DC United", @league_stats.highest_scoring_home_team
  end

  def test_it_can_find_lowest_scoring_visitor
    assert_equal "Chicago Red Stars", @league_stats.lowest_scoring_visitor
  end

  def test_it_can_find_lowest_scoring_home_team
    assert_equal "New York City FC", @league_stats.lowest_scoring_home_team
  end
end
