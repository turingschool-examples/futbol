require_relative 'test_helper'
require_relative '../lib/stat_tracker'
require 'pry'

class StatTrackerTest < Minitest::Test

	def setup
		game_path = './data/games.csv'
		team_path = './data/teams.csv'
		game_teams_path = './data/game_teams.csv'
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

	def test_dig_module_can_pull_single_team
		assert_instance_of Team, @stat_tracker.team(17)
		assert_equal 17, @stat_tracker.team(17).id
	end

	def test_dig_module_can_pull_single_game
		assert_instance_of Game, @stat_tracker.game(2012030221)
		assert_equal 2012030221, @stat_tracker.game(2012030221).id
	end

end
