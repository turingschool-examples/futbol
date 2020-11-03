require_relative './test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stattracker = StatTracker.from_csv(locations)
  end

  def test_it_exists_and_has_attributes

    assert_instance_of StatTracker, @stattracker
  end

  def test_highest_total_score

    assert_equal 5, @stattracker.highest_total_score
  end

  def test_lowest_total_score

    assert_equal 1, @stattracker.lowest_total_score
  end

  def test_percentage_home_wins

    assert_equal 0.54, @stattracker.percentage_home_wins
  end

  def test_percentage_visitor_wins

    assert_equal 0.38, @stattracker.percentage_visitor_wins
  end

  def test_percentage_ties

    assert_equal 0.08, @stattracker.percentage_ties
  end

  def test_count_of_games_by_season

    expected = {"20122013"=> 12, "20132014"=> 1}
    assert_equal expected, @stattracker.count_of_games_by_season
  end

  def test_average_goals_per_game

    assert_equal 3.38, @stattracker.average_goals_per_game
  end

  def test_average_goals_by_season

    expected = {"20122013"=> 3.50, "20132014"=> 2.00}
    assert_equal expected, @stattracker.average_goals_by_season
  end

  def test_count_of_teams

    assert_equal 32, @stattracker.count_of_teams
  end

  def test_best_offense

    assert_equal "FC Dallas", @stattracker.best_offense
  end

  def test_worst_offense

    assert_equal "Houston Dynamo", @stattracker.worst_offense
  end

  def test_highest_scoring_visitor

    assert_equal "FC Dallas", @stattracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team

    assert_equal "FC Dallas", @stattracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor

    assert_equal "Houston Dynamo", @stattracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team

    assert_equal "Houston Dynamo", @stattracker.lowest_scoring_home_team
  end

  def test_team_info
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }
    assert_equal expected, @stattracker.team_info("18")
  end

  def test_best_season

    assert_equal "20132014", @stattracker.best_season("17")
  end

  def test_worst_season

    assert_equal "20132014", @stattracker.worst_season("16")
  end

  def test_average_win_percentage

    assert_equal 0.5, @stattracker.average_win_percentage("17")
  end

  def test_most_goals_scored

    assert_equal 2, @stattracker.most_goals_scored("16")
  end

  def test_fewest_goals_scored

    assert_equal 0, @stattracker.fewest_goals_scored("16")
  end

  def test_favorite_opponent

    assert_equal "LA Galaxy", @stattracker.favorite_opponent("16")
  end

  def test_rival

    assert_equal "Houston Dynamo", @stattracker.rival("6")
  end

  def test_winningest_coach

    assert_equal "Claude Julien", @stattracker.winningest_coach("20122013")
  end

  def test_worst_coach

    assert_equal "John Tortorella", @stattracker.worst_coach("20122013")
  end

  def test_most_accurate_team

    assert_equal "FC Dallas", @stattracker.most_accurate_team("20122013")
  end

  def test_least_accurate_team

    assert_equal "Houston Dynamo", @stattracker.least_accurate_team("20122013")
  end

  def test_most_tackles

    assert_equal "Houston Dynamo", @stattracker.most_tackles("20122013")
  end

  def test_fewest_tackles

    assert_equal "FC Dallas", @stattracker.fewest_tackles("20122013")
  end

end
