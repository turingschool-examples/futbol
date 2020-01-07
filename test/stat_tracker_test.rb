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

    team1 = mock("Team1")
    team1.stubs(:team_id => "1",
								:average_goals_away => 1,
                :average_goals_home => 2,
                :average_goals_total => 1.5,
                :win_percent_total => 1.0,
                :home_win_percentage => 0.5,
                :away_win_percentage => 2.0,
                :total_scores_against => 3,
                :team_name => "Fake 1")
    team2 = mock("Team2")
    team2.stubs(:team_id => "2",
								:average_goals_away => 2,
                :average_goals_home => 3,
                :average_goals_total => 2.5,
                :win_percent_total => 4.0,
                :home_win_percentage => 1.5,
                :away_win_percentage => 2.5,
                :total_scores_against => 7,
                :team_name => "Fake 2")
    team3 = mock("Team3")
    team3.stubs(:team_id => "3",
								:average_goals_away => 0,
                :average_goals_home => 1,
                :average_goals_total => 0.5,
                :win_percent_total => 2.5,
                :home_win_percentage => 2.0,
                :away_win_percentage => 1.5,
                :total_scores_against => 2,
                :team_name => "Fake 3")
    team4 = mock("Team4")
    team4.stubs(:team_id => "4",
								:average_goals_away => 5,
                :average_goals_home => 4,
                :average_goals_total => 4.5,
                :win_percent_total => 0.5,
                :home_win_percentage => 4.5,
                :away_win_percentage => 0.5,
                :total_scores_against => 4,
                :team_name => "Fake 4")
  	# game1 = mock("Game1")
  	# game1.stubs(:away_team_id => 2,
		# 				  	:home_team_id => 1,
		# 				  	:away_goals => 5,
		# 				  	:home_goals => 2)
  	# game2 = mock("Game2")
  	# game2.stubs(:away_team_id => 1,
		# 					  :home_team_id => 2,
		# 				  	:away_goals => 4,
		# 				  	:home_goals => 1)
		#
		# away_games = [game1]
		# home_games = [game2]
		#
		# team1.stubs(:away_games => away_games, :home_games => home_games)
		# team2.stubs(:away_games => away_games, :home_games => home_games)
		# team3.stubs(:away_games => away_games, :home_games => home_games)
		# team4.stubs(:away_games => away_games, :home_games => home_games)

    fake_teams = [team1, team2, team3, team4]

    @stat_tracker.stubs(:teams => fake_teams)

		@stat_tracker2 = StatTracker.from_csv(locations)
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

	def test_team_can_return_most_goals_scored
		assert_equal 2, @stat_tracker2.most_goals_scored("3")
	end

	def test_team_can_return_fewest_goals_scored
		assert_equal 1, @stat_tracker2.fewest_goals_scored("3")
	end

	def test_team_info_can_be_returned
		expected = {"team_id"=>"3",
		 "franchise_id"=>"10",
		 "team_name"=>"Houston Dynamo",
		 "abbreviation"=>"HOU",
		 "link"=>"/api/v1/teams/3"}
		assert_equal expected, @stat_tracker2.team_info("3")
	end

	def test_average_win_percentage_can_be_returned
		assert_equal 0.0, @stat_tracker2.average_win_percentage("3")
	end

	def test_seasonal_summary_can_be_generated
		expected = {"20122013"=>
						  {:regular_season=>
						    {:win_percentage=>0.0,
						     :total_goals_scored=>0.0,
						     :total_goals_against=>0.0,
						     :average_goals_scored=>0.0,
						     :average_goals_against=>0.0},
						   :postseason=>
						    {:win_percentage=>0.0,
						     :total_goals_scored=>8.0,
						     :total_goals_against=>14.0,
						     :average_goals_scored=>1.6,
						     :average_goals_against=>2.8}},
						 "20132014"=>
						  {:regular_season=>
						    {:win_percentage=>0.0,
						     :total_goals_scored=>0.0,
						     :total_goals_against=>0.0,
						     :average_goals_scored=>0.0,
						     :average_goals_against=>0.0},
						   :postseason=>
						    {:win_percentage=>0.0,
						     :total_goals_scored=>0.0,
						     :total_goals_against=>0.0,
						     :average_goals_scored=>0.0,
						     :average_goals_against=>0.0}}}
				assert_equal expected, @stat_tracker2.seasonal_summary("3")
	end

	def test_worst_season_can_be_returned
		assert_equal "20122013", @stat_tracker2.worst_season("3")
	end

	def test_best_season_can_be_returned
		assert_equal "20122013", @stat_tracker2.best_season("1")
	end

	# def test_coach_winningest_can_be_returned
	# 	binding.pry
	# end

	def test_least_accurate_team_can_be_returned
		assert_equal "Chicago Fire", @stat_tracker2.least_accurate_team("20132014")
	end

	def test_most_accurate_team_can_be_returned
		assert_equal "Atlanta United", @stat_tracker2.most_accurate_team("20122013")
	end

	def test_biggest_suprise_can_be_returned
		assert_equal "Houston Dynamo", @stat_tracker2.biggest_surprise("20122013")
	end

	def test_biggest_bust_can_be_returned
		assert_equal "Atlanta United", @stat_tracker2.biggest_bust("20122013")
	end

	# def test_worst_coach_can_be_returned
	# 	binding.pry
	# end
end
