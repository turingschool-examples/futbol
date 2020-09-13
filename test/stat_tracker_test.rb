require_relative 'test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }

    @stat_tracker = StatTracker.new(@locations)
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  # def test_it_exists
  #  assert_instance_of StatTracker, @stat_tracker
  # end

  # def test_from_csv
  #   assert_instance_of StatTracker, @stat_tracker
  # end

  # def test_it_has_attributes
  #   @game_manager = GameManager.new(@locations[:games], self)
  #   @game_teams_manager = GameTeamsManager.new(@locations[:game_teams], self)
  #   @team_manager = TeamManager.new(@locations[:teams], self)

  #   assert_instance_of GameManager, @stat_tracker.game_manager
  #   assert_instance_of TeamManager, @stat_tracker.team_manager
  #   assert_instance_of GameTeamsManager, @stat_tracker.game_teams_manager
  # end

  # def test_the_highest_score
  #   assert_equal 11, @stat_tracker.highest_total_score
  # end

  # def test_it_can_find_lowest_total_score
  #   assert_equal 0, @stat_tracker.lowest_total_score
  # end

  # def test_it_knows_percentage_home_wins
  #   assert_equal 0.44, @stat_tracker.percentage_home_wins
  # end

  # def test_it_knows_percentage_visitor_wins
  #   assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  #

  # def test_it_knows_percentage_ties
  #   assert_equal 0.20, @stat_tracker.percentage_ties
  # end

  # def test_it_knows_count_of_games_by_season
  #   expected = {
  #     "20122013"=>806,
  #     "20162017"=>1317,
  #     "20142015"=>1319,
  #     "20152016"=>1321,
  #     "20132014"=>1323,
  #     "20172018"=>1355
  #   }
  #   assert_equal expected, @stat_tracker.count_of_games_by_season
  # end

  # def test_average_goals_by_season
  #   expected = {
  #     "20122013"=>4.12,
  #     "20162017"=>4.23,
  #     "20142015"=>4.14,
  #     "20152016"=>4.16,
  #     "20132014"=>4.19,
  #     "20172018"=>4.44
  #   }

  #     assert_equal expected, @stat_tracker.average_goals_by_season
  # end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end
end
