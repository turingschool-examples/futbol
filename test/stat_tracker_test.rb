require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_show_highest_total_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_can_show_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 8, @stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_best_defense
    assert_equal "FC Cincinnati", @stat_tracker.best_defense
  end

  def test_worst_defense
    assert_equal "Columbus Crew SC", @stat_tracker.worst_defense
  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_winningest_team
    assert_equal "Reign FC", @stat_tracker.winningest_team
  end

  def test_best_fans
    assert_equal "San Jose Earthquakes", @stat_tracker.best_fans
  end

  def test_worst_fans
    assert_equal ["Houston Dynamo", "Utah Royals FC"], @stat_tracker.worst_fans
  end

  def test_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    assert_equal expected, @stat_tracker.team_info("18")
  end

  def test_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_worst_season
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_average_win_percentage
    assert_equal 0.49, @stat_tracker.average_win_percentage("6")
  end

  def test_most_goals_scored
    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end
end
