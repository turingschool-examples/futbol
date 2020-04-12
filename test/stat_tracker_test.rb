require './test/test_helper'
require './lib/stat_tracker'
require 'mocha/minitest'

class StatTrackerTest < Minitest::Test

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
  end

  def test_it_exists
<<<<<<< HEAD

=======
>>>>>>> master
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_has_attributes
<<<<<<< HEAD

    assert_equal  './data/games_fixture.csv', @stat_tracker.games
    assert_equal  './data/teams.csv', @stat_tracker.teams
    assert_equal  './data/game_teams_fixture.csv', @stat_tracker.game_teams
  end

  def test_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_calculate_percentage_of_home_wins
    assert_equal 0.63, @stat_tracker.percentage_home_wins
  end
  #
  def test_it_can_calculate_percentage_of_visitor_game_wins
    assert_equal 0.25, @stat_tracker.percentage_visitor_wins
  end
  #
  def test_it_can_calculate_percenatage_ties
    assert_equal 0.13, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013"=>12, "20132014"=>3, "20172018"=>3, "20162017"=>3, "20152016"=>1, "20142015"=>5}), @stat_tracker.count_of_games_by_season
  end

  def test_average_number_of_goals_per_game
    assert_equal 4.11,@stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({"20122013"=>4.0, "20132014"=>4.0, "20172018"=>3.67, "20162017"=>4.33, "20152016"=>4.0, "20142015"=>4.6}), @stat_tracker.average_goals_by_season
=======
    assert_equal  './data/games_fixture.csv', @stat_tracker.games
    assert_equal  './data/teams.csv', @stat_tracker.teams
    assert_equal  './data/game_teams_fixture.csv', @stat_tracker.game_teams
    assert_instance_of LeagueStatistics, @stat_tracker.league_statistics
    assert_instance_of TeamStatistics, @stat_tracker.team_statistics
    assert_instance_of GameStatistics, @stat_tracker.game_statistics
  end

  # def test_highest_total_score
  #   stat_tracker.highest_total_score
  #   stat_tracker.lowest_total_score
  # end
  #
  # def test_lowest_total_score
  #   stat_tracker.lowest_total_score
  # end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.league_statistics.count_of_teams
  end

  def test_best_offense
    @stat_tracker.league_statistics.stubs(:average_goals_by_team).returns({"1" => 1, "6" => 2.5, "3" => 2.2})
    assert_equal "FC Dallas", @stat_tracker.league_statistics.best_offense
  end

  def test_worst_offense
    @stat_tracker.league_statistics.stubs(:average_goals_by_team).returns({"1" => 2.5, "6" => 2, "3" => 1.3})
    expected = "Houston Dynamo"
    assert_equal expected, @stat_tracker.league_statistics.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.league_statistics.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal "Sporting Kansas City", @stat_tracker.league_statistics.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Real Salt Lake", @stat_tracker.league_statistics.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal "Seattle Sounders FC", @stat_tracker.league_statistics.lowest_scoring_home_team
  end

  def test_team_info
    expected1 = {"team_id" => "1", "franchise_id" => "23", "team_name" => "Atlanta United", "abbreviation" => "ATL", "link" => "/api/v1/teams/1"}
    expected2 = {"team_id" => "4", "franchise_id" => "16", "team_name" => "Chicago Fire", "abbreviation" => "CHI", "link"=> "/api/v1/teams/4"}

    assert_equal expected1, @stat_tracker.team_statistics.team_info("1")
    assert_equal expected2, @stat_tracker.team_statistics.team_info("4")
  end

  def test_best_season
      assert_equal "20132014", @stat_tracker.team_statistics.best_season("24")
  end

  def test_worst_season
    assert_equal "20142015", @stat_tracker.team_statistics.worst_season("24")
  end

  def test_average_win_percentage
    assert_equal 0.33, @stat_tracker.team_statistics.average_win_percentage("22")
    assert_equal 0, @stat_tracker.team_statistics.average_win_percentage("3")
    assert_equal 1, @stat_tracker.team_statistics.average_win_percentage("6")
  end

  def test_most_goals_scored
    assert_equal 1, @stat_tracker.team_statistics.most_goals_scored("5")
    assert_equal 2, @stat_tracker.team_statistics.most_goals_scored("3")
    assert_equal 4, @stat_tracker.team_statistics.most_goals_scored("6")
  end

  def test_fewest_goals_scored
    assert_equal 0, @stat_tracker.team_statistics.fewest_goals_scored("5")
    assert_equal 1, @stat_tracker.team_statistics.fewest_goals_scored("3")
    assert_equal 1, @stat_tracker.team_statistics.fewest_goals_scored("6")
  end

  def test_favorite_opponent
    assert_equal "Houston Dynamo", @stat_tracker.team_statistics.favorite_opponent("6")
    assert_equal "Philadelphia Union", @stat_tracker.team_statistics.favorite_opponent("22")
  end

  def test_rival
    assert_equal "Washington Spirit FC", @stat_tracker.team_statistics.rival("24")
    assert_equal "Orlando Pride", @stat_tracker.team_statistics.rival("17")
>>>>>>> master
  end

end
