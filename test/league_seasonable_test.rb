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
	end

	def teardown
		Game.reset_all
  	end
	
	def test_team_ids
		assert_includes @stat_tracker.team_ids, 4
	end

	def test_games_between_teams
		assert_includes @stat_tracker.games_between_teams(2, 1), [1, 0, 3]
	end
	

	def test_rival
		assert_equal @stat_tracker.rival(6), "Houston Dynamo"
	end

	def test_favorite_opponenet
		assert_equal @stat_tracker.favorite_opponent(3), "FC Dallas"
	end

	def test_team_from_id
		assert_equal @stat_tracker.team_from_id(1), "Atlanta United"
	end

	def test_organize_by_team
		assert_equal @stat_tracker.organize_by_team([[1, 0, 3], [1, 2, 2], [1, 3, 3]]), {1=>[[0, 3], [2, 2], [3, 3]]}
	end

	def test_win_percent_by_opp
		assert_equal @stat_tracker.win_percent_by_opp({5 => [[1, 0], [2, 0]]}), {5=>1.0}
	end

	def test_win
		assert_equal @stat_tracker.win?([1, 0]), true
	end

	def test_convert_to_wins
		assert_equal @stat_tracker.convert_to_wins({5 => [1, 0]}), {5=>[true, false]}
	end
	
	def test_win_percent
		assert_equal @stat_tracker.win_percent([3, 1]), 1.0
	end

	def test_biggest_team_blowout
		assert_equal @stat_tracker.biggest_team_blowout("6"), 2
	end
	def test_worst_loss
		assert_equal @stat_tracker.worst_loss("6"), 1
	end

	def test_win_loss_difference
		assert_equal @stat_tracker.win_loss_difference(@stat_tracker.games_for_team(5)), [-3, -3, -1, -1]
	end
	
	def test_head_to_head
		assert_equal @stat_tracker.head_to_head("6"), {"Houston Dynamo"=>1.0}
	end		
		
end

