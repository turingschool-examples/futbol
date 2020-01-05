require_relative 'test_helper'
require 'mocha/minitest'
require_relative '../lib/stat_tracker'
require 'pry'

class StatTrackerTest < Minitest::Test
	def setup
		game_path = './test/fixtures/truncated_games.csv'
		team_path = './test/fixtures/truncated_teams.csv'
		game_teams_path = './test/fixtures/truncated_game_teams.csv'
		locations = {
		  games: game_path,
		  teams: team_path,
		  game_teams: game_teams_path
		}

    @stat_tracker = StatTracker.from_csv(locations)
    
#    team1 = mock("Team1")
#    team1.stubs(:average_goals_away => 1,
#                :average_goals_home => 2,
#                :average_goals_total => 1.5,
#                :win_percent_total => 1.0,
#                :home_win_percentage => 0.5,
#                :away_win_percentage => 2.0,
#                :total_scores_against => 3,
#                :team_name => "Fake 1")
#    team2 = mock("Team2")
#    team2.stubs(:average_goals_away => 2,
#                :average_goals_home => 3,
#                :average_goals_total => 2.5,
#                :win_percent_total => 4.0,
#                :home_win_percentage => 1.5,
#                :away_win_percentage => 2.5,
#                :total_scores_against => 7,
#                :team_name => "Fake 2")
#    team3 = mock("Team3")
#    team3.stubs(:average_goals_away => 0,
#                :average_goals_home => 1,
#                :average_goals_total => 0.5,
#                :win_percent_total => 2.5,
#                :home_win_percentage => 2.0,
#                :away_win_percentage => 1.5,
#                :total_scores_against => 2,
#                :team_name => "Fake 3")
#    team4 = mock("Team4")
#    team4.stubs(:average_goals_away => 5,
#                :average_goals_home => 4,
#                :average_goals_total => 4.5,
#                :win_percent_total => 0.5,
#                :home_win_percentage => 4.5,
#                :away_win_percentage => 0.5,
#                :total_scores_against => 4,
#                :team_name => "Fake 4")
#
#    fake_teams = [team1, team2, team3, team4]
#
#    @stat_tracker.stubs(:teams => fake_teams)
	binding.pry
  end
  
  def teardown
    Game.reset_all
  end

	def test_it_exists
		assert_instance_of StatTracker, @stat_tracker
	end

  def test_stat_tracker_attributes
		assert_instance_of Array, @stat_tracker.seasons
		assert_instance_of Array, @stat_tracker.teams
		assert_instance_of Season, @stat_tracker.seasons.first
		assert_instance_of Season, @stat_tracker.seasons.last
  end
  
  def test_find_count_of_games
    assert_equal 4, @stat_tracker.count_of_teams
  end

	def test_highest_scoring_visitor
		assert_equal "Fake 4", @stat_tracker.highest_scoring_visitor
	end

	def test_highest_scoring_home_team
		assert_equal "Fake 4", @stat_tracker.highest_scoring_home_team
	end

	def test_lowest_scoring_visitor
		assert_equal "Fake 3", @stat_tracker.lowest_scoring_visitor
	end

  def test_lowest_scoring_home_team
		assert_equal "Fake 3", @stat_tracker.lowest_scoring_home_team
  end
  
  def test_find_team_with_best_offense
    assert_equal "Fake 4", @stat_tracker.best_offense
  end

  def test_find_team_with_worst_offense
    assert_equal "Fake 3", @stat_tracker.worst_offense
  end

  def test_find_team_with_best_win_percentage
    assert_equal "Fake 2", @stat_tracker.winningest_team
  end

  def test_find_array_of_teams_with_worst_fans
    assert_instance_of Array, @stat_tracker.worst_fans
    assert_equal ["Fake 4"], @stat_tracker.worst_fans
  end

  def test_can_find_team_with_highest_home_away_difference
    assert_equal "Fake 4", @stat_tracker.best_fans
  end

  def test_return_team_with_lowest_scores_against
    assert_equal "Fake 3", @stat_tracker.best_defense
  end

  def test_return_team_with_highest_scores_against
    assert_equal "Fake 2", @stat_tracker.worst_defense
  end

  def test_can_find_the_highest_and_lowest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_find_game_with_biggest_blowout
    assert_equal 3, @stat_tracker.biggest_blowout
  end

  def test_can_find_percent_home_and_away_team_win
    assert_equal 0.48, @stat_tracker.percentage_home_wins
    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_can_find_percentage_of_ties
    assert_equal 0.19, @stat_tracker.percentage_ties
  end

  def test_can_find_average_goal_per_game
    assert_equal 4.24, @stat_tracker.average_goals_per_game
  end
end
