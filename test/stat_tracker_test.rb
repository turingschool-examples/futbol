require './test/test_helper'
require './lib/stat_tracker'

class TestStatTracker < Minitest::Test

# MAKE SETUP LATER

    def test_it_exists
        tracky = StatTracker.new

        assert_instance_of StatTracker, tracky
    end

    def test_it_has_game_stat_attributes
        tracky = StatTracker.new
        
        assert_equal 0, tracky.highest_total_score
        assert_equal 0, tracky.lowest_total_score
        assert_equal 0.0, tracky.percentage_home_wins
        assert_equal 0.0, tracky.percentage_visitor_wins
        assert_equal 0.0, tracky.percentage_ties
        # TBD FIGURE OUT WHAT HASH LOOKS LIKE:
        assert_equal {}, tracky.count_of_games_by_season
        assert_equal 0.0, tracky.average_goals_per_game
        # SAMESIES:
        assert_equal {}, tracky.average_goals_by_season
    end
    
    def test_it_has_league_stat_attributes
        tracky = StatTracker.new

        assert_equal 0, tracky.count_of_teams
        assert_equal "", tracky.best_offense
        assert_equal "", tracky.worst_offense
        assert_equal "", tracky.highest_scoring_visitor
        assert_equal "", tracky.highest_scoring_home_team
        assert_equal "", tracky.lowest_scoring_visitor
        assert_equal "", tracky.lowest_scoring_home_team        
    end
    
    def test_it_has_season_stat_attributes
        tracky = StatTracker.new

        # will take (season ID) as an arguement
        assert_equal "", tracky.winningest_coach()
        assert_equal "", tracky.worst_coach()
        assert_equal "", tracky.most_accurate_team()
        assert_equal "", tracky.least_accurate_team()
        assert_equal "", tracky.most_tackles()
        assert_equal "", tracky.fewest_tackles()
    end
    
    def test_it_has_team_stat_attributes
        tracky = StatTracker.new

        # WILL HAVE (TEAM ID) AS ARGUMENT
        # NEED TO EDIT HASH ONCE WE KNOW MORE
        assert_equal {}, tracky.team_info()
        assert_equal "", tracky.best_season()
        assert_equal "", tracky.worst_season()
        assert_equal 0.0, tracky.average_win_percentage()
        assert_equal 0, tracky.most_goals_scored()
        assert_equal 0, tracky.fewest_goals_scored()
        assert_equal "", tracky.favorite_opponent()
        assert_equal "", tracky.rival()
    end

end