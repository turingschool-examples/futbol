require './lib/stat_tracker'
require './lib/league_statistics'
require './test/test_helper'

class LeagueStatisticsTest < Minitest::Test
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
    @league_statistics = LeagueStatistics.new(@stat_tracker)
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end
# League Statistic Tests
  def test_it_can_count_number_of_teams
    assert_equal 32, @league_statistics.count_of_teams
  end

  def test_it_knows_highest_average_goals_scored_across_season
	# Name of the team with the highest average number of goals scored per game across all seasons.
    assert_equal 'FC Dallas', @league_statistics.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
  # Name of the team with the highest average number of goals scored per game across all seasons.
    assert_equal 'Sporting Kansas City', @league_statistics.worst_offense
  end

  def test_it_knows_highest_average_away
  # Name of the team with the highest average score per game across all seasons when they are away.
    assert_equal 'Real Salt Lake', @league_statistics.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
  # Name of the team with the highest average score per game across all seasons when they are away.
    assert_equal 'Real Salt Lake', @league_statistics.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
  # Name of the team with the highest average score per game across all seasons when they are away.
    assert_equal 'Sporting Kansas City', @league_statistics.lowest_scoring_visitor
  end

  def test_it_knows_lowest_average_home
  # Name of the team with the highest average score per game across all seasons when they are away.
    assert_equal 'Sporting Kansas City', @league_statistics.lowest_scoring_home_team
  end

# Helper Tests
  def test_it_can_find_highest_goal

    assert_equal '6', @league_statistics.find_highest_goal_team_id
  end

  def test_it_can_find_lowest_goal

    assert_equal '5', @league_statistics.find_lowest_goal_team_id
  end

  def test_it_can_find_total_games_per_team_id_away
    expected = {"3"=>3, "6"=>4, "5"=>2, "20"=>2, "24"=>2}

    assert_equal expected, @league_statistics.total_games_per_team_id_away
  end

  def test_it_can_find_total_games_per_team_id_home
    expected = {"6"=>5, "3"=>2, "5"=>2, "24"=>2, "20"=>2}
    assert_equal expected, @league_statistics.total_games_per_team_id_home
  end

  def test_it_knows_total_goals_per_team_id_away
    expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    assert_equal expected, @league_statistics.total_goals_per_team_id_away
  end

  def test_it_knows_total_goals_per_team_id_home
    expected = {"6"=>12.0, "3"=>3.0, "5"=>1.0, "24"=>6.0, "20"=>3.0}
    assert_equal expected, @league_statistics.total_goals_per_team_id_home
  end

  def test_it_can_find_highest_average_team_id_visitor

    assert_equal "24", @league_statistics.highest_average_team_id_visitor
  end

  def test_it_can_find_highest_average_team_id_home

    assert_equal "24", @league_statistics.highest_average_team_id_home
  end

  def test_it_can_find_lowest_average_team_id_visitor

    assert_equal "5", @league_statistics.lowest_average_team_id_visitor
  end

  def test_it_can_find_lowest_average_team_id_home

    assert_equal "5", @league_statistics.lowest_average_team_id_home
  end

end
