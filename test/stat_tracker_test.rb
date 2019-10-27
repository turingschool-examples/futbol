require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_collection'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/data/games_sample.csv'
    team_path = './test/data/teams_sample.csv'
    game_teams_path = './test/data/game_teams_sample.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    stat_tracker = StatTracker.new('./test/data/games_sample.csv', './test/data/teams_sample.csv', './test/data/game_teams_sample.csv')
    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_from_csv
    # need test for self.from_csv method
  end

  def test_it_has_highest_total_score
    assert_equal 10, @stat_tracker.highest_total_score
  end

  def test_it_has_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_it_has_biggest_blowout
    assert_equal 6, @stat_tracker.biggest_blowout
  end

  def test_it_has_percentage_home_wins
    assert_equal 0.45, @stat_tracker.percentage_home_wins
  end

  def test_it_has_percentage_visitor_wins
    assert_equal 0.40, @stat_tracker.percentage_visitor_wins
  end

  def test_it_has_percentage_ties
    assert_equal 0.15, @stat_tracker.percentage_ties
  end

  def test_it_has_count_of_games_by_season
    count_games_by_season_list = {
      "20172018" => 10,
      "20152016" => 10
    }
    assert_equal count_games_by_season_list, @stat_tracker.count_of_games_by_season
  end

  def test_it_has_average_goals_per_game
    assert_equal 4.60, @stat_tracker.average_goals_per_game
  end

  def test_it_has_average_goals_by_season
    count_goals_by_season_list = {
      "20172018" => 4.10,
      "20152016" => 5.1
    }
    assert_equal count_goals_by_season_list, @stat_tracker.average_goals_by_season
  end

  def test_it_has_count_of_teams
    assert_equal 3, @stat_tracker.count_of_teams
  end

  def test_it_has_best_offense
    assert_equal "FC Cincinnati", @stat_tracker.best_offense
  end

  def test_it_has_worst_offense
    assert_equal "Atlanta United", @stat_tracker.worst_offense
  end

  def test_it_has_best_defense
    assert_equal "Atlanta United", @stat_tracker.best_defense
  end

  def test_it_has_the_worst_defense
    assert_equal "Chicago Fire", @stat_tracker.worst_defense
  end

  def test_it_has_winningest_team
    assert_equal "FC Cincinnati", @stat_tracker.winningest_team
  end

  def test_it_has_best_fans
    assert_equal "FC Cincinnati", @stat_tracker.best_fans
  end

  def test_it_has_worst_fans
    #need to include more data so we an actually get a list of the worst teams?
    assert_equal ["FC Cincinnati"], @stat_tracker.worst_fans
  end

  def test_it_has_highest_scoring_visitor
    assert_equal "Chicago Fire", @stat_tracker.highest_scoring_visitor
  end

  def test_it_has_a_highest_scoring_home_team
    assert_equal "FC Cincinnati", @stat_tracker.highest_scoring_home_team
  end

  def test_it_has_a_lowest_scoring_away_team
    assert_equal "FC Cincinnati", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "Chicago Fire", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_has_winningest_team
    # FC Dallas has only wins
    assert_equal "Atlanta United", @stat_tracker.winningest_team
  end

  def test_it_has_the_best_offense
    assert_equal "FC Cincinnati", @stat_tracker.best_offense
  end

  def test_it_has_best_fans
    assert_equal "FC Cincinnati", @stat_tracker.best_fans
  end

  def test_it_has_worst_fans
    assert_equal ["Chicago Fire"], @stat_tracker.worst_fans
  end
end
