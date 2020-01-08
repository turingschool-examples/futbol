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
		binding.pry
	end

	def teardown
		Game.reset_all
  	end

end

