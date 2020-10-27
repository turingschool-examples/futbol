require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/league_stats'

    class LeagueStatisticsTest < Minitest::Test

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

        stat_tracker = StatTracker.from_csv(locations)
        @teams = stat_tracker.all_data[:teams]
        @league = LeagueStatistics.new(@teams)
        @game_dummy_stats = stat_tracker.all_data[:games_dummy]
    end
    
    def test_it_exisits_and_has_attributes
      assert_instance_of LeagueStatistics, @league
      assert_equal @teams,  @league.stats
    end

    def test_count_of_teams
      assert_equal 32, @league.count_of_teams
    end

    def test_best_offense 
      skip
      assert_equal "Reign FC", @league.best_offense
    end

    def test_worst_offense 
      skip
      assert_equal "Utah Royals FC", @league.worst_offense
    end

    def test_highest_scoring_visitor
      skip
      assert_equal "FC Dallas", @league.highest_scoring_visitor
    end

    def test_highest_scoring_team 
      skip
      assert_equal "Reign FC", @league.highest_scoring_home_team
    end

    def test_lowest_scoring_visitor
      skip
      assert_equal "San Jose Earthquakes", @league.lowest_scoring_visitor
    end

    def test_lowest_scoring_home_team
      skip
      assert_equal "Utah Royals FC", @league.lowest_scoring_home_team
    end
  end 
