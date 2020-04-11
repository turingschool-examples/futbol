require './test/test_helper'
require './lib/stat_tracker'
require './lib/league_statistics'
require 'mocha/minitest'
require 'pry'

class LeagueStatisticsTest < Minitest::Test

  def setup
    game_path = './data/games_fixture.csv'
    team_path = './data/teams.csv'
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

  def test_it_has_readable_attributes
    assert_instance_of Array, @league_statistics.game_collection
    assert_instance_of Array, @league_statistics.game_teams_collection
    assert_instance_of Array, @league_statistics.teams_collection

    assert_equal "2012030221", @league_statistics.game_collection[0].game_id
    assert_equal "2014030326", @league_statistics.game_collection[-1].game_id

    assert_equal "2012030221", @league_statistics.game_teams_collection[0].game_id
    assert_equal "2012030124", @league_statistics.game_teams_collection[-1].game_id

    assert_equal "1", @league_statistics.teams_collection[0].id
    assert_equal "53", @league_statistics.teams_collection[-1].id
  end

  def test_count_of_teams
    assert_equal 32, @league_statistics.count_of_teams
  end

  def test_best_offense
    @league_statistics.stubs(:average_goals_by_team).returns({"1" => 1, "6" => 2.5, "3" => 2.2})
    assert_equal "FC Dallas", @league_statistics.best_offense
  end

  def test_worst_offense
      @league_statistics.stubs(:average_goals_by_team).returns({"1" => 2.5, "6" => 2, "3" => 1.3})
    expected = "Houston Dynamo"
    assert_equal expected, @league_statistics.worst_offense
  end

  def test_games_played_by_team
    expected = { "3"=>5,
                 "6"=>10,
                 "5"=>4,
                 "19"=>2,
                 "23"=>2,
                 "24"=>9,
                 "4"=>2,
                 "29"=>2,
                 "12"=>1,
                 "17"=>2,
                 "1"=>1,
                 "2"=>1,
                 "22"=>3,
                 "8"=>1,
                 "14"=>2,
                 "25"=>1,
                 "7"=>1,
                 "16"=>5}
    assert_equal expected, @league_statistics.games_played_by_team
  end

  def test_goals_scored_by_team
    expected = { "3"=>8,
                 "6"=>28,
                 "5"=>2,
                 "19"=>3,
                 "23"=>4,
                 "24"=>22,
                 "4"=>4,
                 "29"=>4,
                 "12"=>2,
                 "17"=>3,
                 "1"=>3,
                 "2"=>0,
                 "22"=>6,
                 "8"=>2,
                 "14"=>4,
                 "25"=>2,
                 "7"=>2,
                 "16"=>12}
    assert_equal expected, @league_statistics.goals_scored_by_team
  end

  def test_average_goals
    assert_equal 0.5, @league_statistics.average_goals(2,4)
  end

  def test_average_goals_by_team
    @league_statistics.stubs(:games_played_by_team).returns({"1" => 5, "2" => 10, "3" => 2})
    @league_statistics.stubs(:goals_scored_by_team).returns({"1" => 5, "2" => 20, "3" => 1})

    expected = {"1"=> 1, "2"=> 2, "3"=> 0.5}
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
