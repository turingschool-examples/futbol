require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'

    class StatTrackerTest < Minitest::Test

    def setup
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'
        dummy_path = './data/dummy.csv'

        locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
            dummy: dummy_path
        }

        stat_tracker = StatTracker.from_csv(locations)
        @stat_tracker = StatTracker.new
    end

    def test_it_exists_with_attributes
        assert_instance_of StatTracker, @stat_tracker
    end
end


