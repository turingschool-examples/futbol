require_relative 'test_helper'
require_relative '../lib/stat_tracker'
require 'pry'

class StatTrackerTest < Minitest::Test

	def setup
		game_path = './test/fixtures/truncated_games.csv'
		team_path = './data/teams.csv'
		game_teams_path = './test/fixtures/truncated_game_teams.csv'
		locations = {
		  games: game_path,
		  teams: team_path,
		  game_teams: game_teams_path
		}

		@stat_tracker = StatTracker.from_csv(locations)
	end

	def test_it_exists
		assert_instance_of StatTracker, @stat_tracker
	end

	def test_stat_tracker_attributes
		assert_instance_of Array, @stat_tracker.seasons
		assert_instance_of Array, @stat_tracker.teams
		assert_instance_of Season, @stat_tracker.seasons.first
		assert_instance_of Season, @stat_tracker.seasons.last
		assert_instance_of Team, @stat_tracker.teams.first
		assert_instance_of Team, @stat_tracker.teams.last
	end

	def test_highest_scoring_visitor
		@stat_tracker.highest_scoring_visitor
	end
end
