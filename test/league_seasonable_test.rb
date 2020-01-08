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

	def test_win_loss_difference
		binding.pry
		assert_equal
	
	def test_head_to_head
		binding.pry
		assert_equal @stat_tracker.head_to_head("6"), {"Houston Dynamo"=>1.0}
	end		
		
end

