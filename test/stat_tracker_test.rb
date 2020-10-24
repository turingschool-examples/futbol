require './test/test_helper'
require './lib/stat_tracker'

class TestStatTracker < Minitest::Test

    def setup
        # move this into self.from CSV! (below code)
        game_path = './dummy_data/games_dummy.csv'
        team_path = './dummy_data/teams_dummy.csv'
        game_teams_path = './dummy_data/game_teams_dummy.csv'

        locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
        }

        @stat_tracker = StatTracker.from_csv(locations)
    end

    def test_it_exists
        binding.pry
        assert_instance_of StatTracker, @stat_tracker
    end

    def test_it_can_provide_highest_and_lowest_total_score
    # skip
        assert_equal 4, @stat_tracker.highest_total_score
        assert_equal 3, @stat_tracker.lowest_total_score
    end

    # def test_it_can_provide_percentage_wins
    #     tracky = StatTracker.new
        
    #     assert_equal 0.0, tracky.percentage_home_wins
    #     assert_equal 0.0, tracky.percentage_visitor_wins
    #     assert_equal 0.0, tracky.percentage_ties
    # end

    # def test_it_can_provide_count_of_games_by_season
    #     tracky = StatTracker.new

    #     assert_equal Hash.new, tracky.count_of_games_by_season
    # end

    # def test_it_can_provide_average_goals_per_game_and_season
    #     tracky = StatTracker.new

    #     assert_equal 0.0, tracky.average_goals_per_game
    #     assert_equal Hash.new, tracky.average_goals_by_season
    # end
    
    # def test_it_can_provide_count_of_teams
    #     tracky = StatTracker.new

    #     assert_equal 0, tracky.count_of_teams
    # end

    # def test_it_can_provide_best_and_worst_offense
    #     tracky = StatTracker.new

    #     assert_equal "", tracky.best_offense
    #     assert_equal "", tracky.worst_offense
    # end

    # def test_it_can_provide_highest_and_lowest_scoring_teams
    #     tracky = StatTracker.new

    #     assert_equal "", tracky.highest_scoring_visitor
    #     assert_equal "", tracky.highest_scoring_home_team
    #     assert_equal "", tracky.lowest_scoring_visitor
    #     assert_equal "", tracky.lowest_scoring_home_team        
    # end
    
    # def test_it_has_season_stat_attributes
    #     tracky = StatTracker.new
        
    #     # will take (season ID) as an arguement
    #     assert_equal "", tracky.winningest_coach()
    #     assert_equal "", tracky.worst_coach()
    #     assert_equal "", tracky.most_accurate_team()
    #     assert_equal "", tracky.least_accurate_team()
    #     assert_equal "", tracky.most_tackles()
    #     assert_equal "", tracky.fewest_tackles()
    # end
    
    # def test_it_has_team_stat_attributes
    #     tracky = StatTracker.new
    #     # WILL HAVE (TEAM ID) AS ARGUMENT
    #     # NEED TO EDIT HASH ONCE WE KNOW MORE
    #     assert_equal Hash.new, tracky.team_info()
    #     assert_equal "", tracky.best_season()
    #     assert_equal "", tracky.worst_season()
    #     assert_equal 0.0, tracky.average_win_percentage()
    #     assert_equal 0, tracky.most_goals_scored()
    #     assert_equal 0, tracky.fewest_goals_scored()
    #     assert_equal "", tracky.favorite_opponent()
    #     assert_equal "", tracky.rival()
    # end

end