require './test/test_helper'
require './lib/stat_tracker'
require './lib/game_statistics'
require 'pry'

class GameStatisticsTest < Minitest::Test

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
    @game_statistics = @stat_tracker.game_statistics

  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_has_readable_attributes
    assert_instance_of Array, @game_statistics .game_collection
    assert_instance_of Array, @game_statistics.game_teams_collection
    assert_instance_of Array, @game_statistics.teams_collection

    assert_equal "2012030221", @game_statistics .game_collection[0].game_id
    assert_equal "2014030326", @game_statistics .game_collection[-1].game_id
    assert_equal "2012030221", @game_statistics.game_teams_collection[0].game_id
    assert_equal "2012030124", @game_statistics.game_teams_collection[-1].game_id
    assert_equal "1", @game_statistics.teams_collection[0].id
    assert_equal "53", @game_statistics.teams_collection[-1].id

  end

  def test_highest_total_score
    assert_equal 6, @game_statistics.total_score(:high)
  end
  #
  def test_lowest_total_score
    assert_equal 1,  @game_statistics.total_score(:low)
  end
  #
  def test_it_can_calculate_percentage_of_home_wins
    assert_equal 0.63, @game_statistics.percentage_outcomes("home")
  end
  #
  def test_it_can_calculate_percentage_of_visitor_game_wins
    assert_equal 0.25, @game_statistics.percentage_outcomes("away")
  end
  #
  def test_it_can_calculate_percenatage_ties
    assert_equal 0.13, @game_statistics.percentage_outcomes("tie")
  end

  def test_count_of_games_by_season
    assert_equal ({"20122013"=>12, "20132014"=>3, "20172018"=>3, "20162017"=>3, "20152016"=>1, "20142015"=>5}), @game_statistics.count_of_games_by_season
  end

  def test_average_number_of_goals_per_game
    assert_equal 4.11,@game_statistics.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal ({"20122013"=>4.0, "20132014"=>4.0, "20172018"=>3.67, "20162017"=>4.33, "20152016"=>4.0, "20142015"=>4.6}), @game_statistics.average_goals_by_season
  end
end
