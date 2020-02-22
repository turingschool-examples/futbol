require_relative 'test_helper'
require './lib/league_stats'
require './lib/stat_tracker'

class LeagueStatsTest < Minitest::Test
  def setup
    game_path = './data/games_truncated.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_truncated.csv'
    @locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }
    @stat_tracker = StatTracker.from_csv(@locations)
    @league_stats = LeagueStats.new(@stat_tracker.games, @stat_tracker.teams, @stat_tracker.game_teams)
    @game_teams = @league_stats.game_teams[1]
  end

  def test_it_exists
    assert_instance_of LeagueStats, @league_stats
  end

  def test_it_has_attributes
    assert_instance_of Array, @league_stats.games
    assert_instance_of Game, @league_stats.games.first
    assert_instance_of Array, @league_stats.teams
    assert_instance_of Team, @league_stats.teams.first
    assert_instance_of Array, @league_stats.game_teams
    assert_instance_of GameTeam, @league_stats.game_teams.first
  end

  def test_it_can_return_count_of_teams
    assert_equal 32, @league_stats.count_of_teams
  end

  def test_best_offense
    assert_equal "FC Dallas", @league_stats.best_offense
  end

  def test_worst_offense
    assert_equal "FC Cincinnati", @league_stats.worst_offense
  end

  # def test_best_defense
  #
  # end

  # def test_worst_defense
  #
  # end

  def test_highest_scoring_visitor
    assert_equal "Real Salt Lake", @league_stats.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "FC Dallas", @league_stats.highest_scoring_home_team
  end

  def test_game_teams_stats_lowest_visitor_score
    assert_equal "FC Cincinnati", @league_stats.lowest_scoring_visitor
  end

  def test_game_teams_stats_lowest_home_score
    assert_equal "Toronto FC", @league_stats.lowest_scoring_home_team
  end

  def test_returns_winningest_team
      game_path = './data/games_truncated_with_winningest_team.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams_truncated.csv'
      locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }
      stat_tracker = StatTracker.from_csv(locations)
      league_stats = LeagueStats.new(stat_tracker.games, stat_tracker.teams, stat_tracker.game_teams)

    assert_equal "Atlanta United", league_stats.winningest_team
  end

  def test_it_can_best_fans
    assert_equal "FC Dallas", @league_stats.best_fans
  end

  def test_it_can_worst_fans
    assert_equal ["Real Salt Lake", "Minnesota United FC"], @league_stats.worst_fans
  end

  # Helper Methods
  def test_team_stats_find_name
    assert_equal "Chicago Fire", @league_stats.find_name(4)
  end

  def test_returns_unique_team_ids_array
    assert_equal [3, 6, 1, 24, 20, 18, 26], @league_stats.unique_team_ids
  end

  def test_games_by_team
    assert_equal 1, @league_stats.games_by_team(1).count
  end

  def test_total_games_by_team_id
    assert_equal 1, @league_stats.total_games_by_team_id(1)
  end

  def test_total_goals_by_team_id
    assert_equal 2, @league_stats.total_goals_by_team_id(1)
  end

  def test_returns_average_goals
    assert_equal 2, @league_stats.average_goals_per_team(1)
  end

  def test_game_teams_stats_scoring
    assert_equal "FC Cincinnati", @league_stats.scoring('away','low')
    assert_equal "Real Salt Lake", @league_stats.scoring('away','win')
  end

  def test_game_teams_stats_low_or_high
    test_hash = {1 => 4.0, 2 => 5.5, 3 => 4.5}
    assert_equal 2, @league_stats.low_or_high('win', test_hash)
    assert_equal 1, @league_stats.low_or_high('low', test_hash)
  end

  def test_game_teams_stats_update_scoring_hash
    scoring_hash = {}
    result = {6 => [3,1]}
    assert_equal result, @league_stats.update_scoring_hash(scoring_hash, @game_teams)
  end

  def test_game_teams_stats_update_id
    id  = {'id' => [-1, -1]}
    key = 2
    test_hash = {1 => 4.0, 2 => 5.5, 3 => 4.5}
    expected = {'id' => [5.5, 2]}
    assert_equal expected, @league_stats.update_id(id, key, test_hash)
  end
end
