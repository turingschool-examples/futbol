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
            game_teams: game_teams_path,
            dummy: dummy_path
        }

        @stat_tracker = StatTracker.from_csv(locations)
    end

    
    def test_it_exisits_and_has_attributes
        assert_instance_of StatTracker, @stat_tracker
    end

    def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
    end

    def test_best_offense 
    #skip
    assert_equal "Reign FC", @stat_tracker.best_offense
    end

    def test_worst_offense 
    #skip
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
    end

    def test_highest_scoring_visitor
    skip
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
    end

    def test_highest_scoring_team 
    skip
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
    end

    def test_lowest_scoring_visitor
    skip
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
    end

    def test_lowest_scoring_home_team
        skip
        assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
    end
end 

