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

  def test_it_can_find_team_name
    assert_equal 'Columbus Crew SC', @stat_tracker.find_team_name('53')
  end

  def test_it_knows_lowest_average_goals_scored_across_season
  # Name of the team with the highest average number of goals scored per game across all seasons.
    assert_equal 'Sporting Kansas City', @stat_tracker.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
  # Name of the team with the highest average number of goals scored per game across all seasons.
    assert_equal 'Sporting Kansas City', @stat_tracker.worst_offense
  end

  def test_it_knows_highest_scoring_away
  # Name of the team with the highest average score per game across all seasons when they are away.
    @game_team_collection.stubs(:highest_average_team_id_visitor).returns('6')
    assert_equal 'FC Dallas', @game_team_collection.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
  # Name of the team with the highest average score per game across all seasons when they are away.
    @game_team_collection.stubs(:highest_average_team_id_home).returns('54')
    assert_equal 'Reign FC', @game_team_collection.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
  # Name of the team with the highest average score per game across all seasons when they are away.
    @game_team_collection.stubs(:lowest_average_team_id_visitor).returns('27')
    assert_equal 'San Jose Earthquakes', @game_team_collection.lowest_scoring_visitor
  end

  # League Statistics Helper Methods

  def test_it_knows_lowest_average_home
    assert_equal 'Utah Royals FC', @game_team_collection.lowest_scoring_home_team
  end
end
