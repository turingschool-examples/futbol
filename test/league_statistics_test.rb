require './test/test_helper'
require './lib/stat_tracker'
# require './lib/game'
# require './lib/game_team'
# require './lib/team'
require './lib/league_statistics'
# require './lib/game'
require 'pry'

class LeagueStatisticsTest < Minitest::Test

  def setup
  game_path = './data/games_fixture.csv'
  team_path = './data/teams_fixture.csv'
  game_teams_path = './data/game_teams_fixture.csv'

  locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }

  @stat_tracker = StatTracker.from_csv(locations)
  @league_statistics = @stat_tracker.league_statistics
  end

  def test_it_exists
    assert_instance_of LeagueStatistics, @league_statistics
  end
  #Come back to this one. Use a stub
  def test_it_has_readable_attributes
    skip
  end

  def test_count_of_teams
    assert_equal 9, @league_statistics.count_of_teams
  end

  def test_best_offense
    assert_equal "FC Dallas", @league_statistics.best_offense
  end

  def test_worst_offense
    expected = "Sporting Kansas City"
    assert_equal expected, @league_statistics.worst_offense
  end

  def test_games_played_by_team
    expected = {"3" => 5, "6" => 9, "5" => 4}
    assert_equal expected, @league_statistics.games_played_by_team
  end

  def test_goals_scored_by_team
    expected = {"3" => 8, "6" => 24, "5" => 2}
    assert_equal expected, @league_statistics.goals_scored_by_team
  end

  def test_average_goals
    assert_equal 0.5, @league_statistics.average_goals(2,4)
  end

  def test_average_goals_by_team
    expected = {"3"=>1.6, "6"=>2.6666666666666665, "5"=>0.5}
    assert_equal expected, @league_statistics.average_goals_by_team
  end

  def test_highest_scoring_visitor
    @league_statistics.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    @league_statistics.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    @league_statistics.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    @league_statistics.lowest_scoring_home_team
  end
end
