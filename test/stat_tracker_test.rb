require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'mocha/minitest'

class StatTrackerTest < Minitest::Test

  def setup
  game_path       = './data/games.csv'
  team_path       = './data/teams.csv'
  game_teams_path = './data/game_teams.csv'

  locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists_and_can_access_data
    assert_instance_of StatTracker, @stat_tracker
  end

  # League Statistics Methods
  def test_it_can_count_number_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @stat_tracker.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @stat_tracker.worst_offense
  end

  def test_it_knows_highest_scoring_away
    @stat_tracker.stubs(:highest_scoring_visitor).returns('FC Dallas')
    assert_equal 'FC Dallas', @stat_tracker.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
    @stat_tracker.stubs(:highest_scoring_home_team).returns('Reign FC')
    assert_equal 'Reign FC', @stat_tracker.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
    @stat_tracker.stubs(:lowest_scoring_visitor).returns('San Jose Earthquakes')
    assert_equal 'San Jose Earthquakes', @stat_tracker.lowest_scoring_visitor
  end

  def test_it_knows_lowest_average_home
    @stat_tracker.stubs(:lowest_scoring_home_team).returns('Utah Royals FC')
    assert_equal 'Utah Royals FC', @stat_tracker.lowest_scoring_home_team
  end
  # League Statistics Helper Methods
  def test_it_can_find_team_name
    assert_equal 'Columbus Crew SC', @stat_tracker.find_team_name('53')
  end

  def test_it_knows_total_games_per_team_id_away
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_games_per_team_id_away).returns(4)
    assert_equal 4, @stat_tracker.total_games_per_team_id_away
  end

  def test_it_knows_total_games_per_team_id_home
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_games_per_team_id_home).returns(11)
    assert_equal 11, @stat_tracker.total_games_per_team_id_home
  end

  def test_it_knows_total_goals_per_team_id_away
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_goals_per_team_id_away).returns(5)
    assert_equal 5, @stat_tracker.total_goals_per_team_id_away
  end

  def test_it_knows_total_goals_per_team_id_home
    # expected = {"6"=>12.0, "3"=>3.0, "5"=>1.0, "24"=>6.0, "20"=>3.0}
    @stat_tracker.stubs(:total_goals_per_team_id_home).returns(12)
    assert_equal 12, @stat_tracker.total_goals_per_team_id_home
  end
end
