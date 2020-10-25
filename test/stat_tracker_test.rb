require './test/test_helper'
require './lib/stat_tracker'
require './lib/game'

class TestStatTracker < Minitest::Test

    def setup
        # move this into self.from CSV! (below code)
        games_path = './data/games.csv'
        teams_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'

        locations = {
            games: games_path,
            teams: teams_path,
            game_teams: game_teams_path
        }

        @stat_tracker = StatTracker.new(locations)
    end

    def test_it_exists
        assert_instance_of StatTracker, @stat_tracker
    end

    def test_from_csv
      games_path = './data/games.csv'
      teams_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
        games: games_path,
        teams: teams_path,
        game_teams: game_teams_path
      }

      assert_instance_of StatTracker, StatTracker.from_csv(locations)
    end

    def test_make_games
      assert_instance_of Game, @stat_tracker.make_games[0]
      assert_instance_of Game, @stat_tracker.make_games[-1]
    end

    def test_highest_total_score
        assert_equal 11, @stat_tracker.highest_total_score
    end

    def test_lowest_total_score
        assert_equal 0, @stat_tracker.lowest_total_score
    end

    def test_it_calculates_winner
      home_team = Game.new(2012030221, 20122013, "Postseason", "5/16/13", 3, 6, 2, 3, "Toyota Stadium", "/api/v1/venues/null")
      away_team = Game.new(2012030221, 20122013, "Postseason", "5/16/13", 3, 6, 3, 2, "Toyota Stadium", "/api/v1/venues/null")
      tie = Game.new(2012030221, 20122013, "Postseason", "5/16/13", 3, 6, 2, 2, "Toyota Stadium", "/api/v1/venues/null")

      assert_equal :home, @stat_tracker.calculate_winner(home_team)
      assert_equal :away, @stat_tracker.calculate_winner(away_team)
      assert_equal :tie, @stat_tracker.calculate_winner(tie)

    end

    def test_percentage_home_wins
      assert_equal 0.44, @stat_tracker.percentage_home_wins
    end

    def test_percentage_visitor_wins
      assert_equal 0.36, @stat_tracker.percentage_visitor_wins
    end

    def test_percentage_ties
      assert_equal 0.20, @stat_tracker.percentage_ties
    end

    def test_count_games_by_season
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }

      assert_equal expected, @stat_tracker.count_of_games_by_season
    end

    def test_it_can_average_goals_per_game
      #change back to actual test / data
      assert_equal 3.25 ,  @stat_tracker.average_goals_per_game
    end
    
    def test_it_can_average_goals_by_season
      expected = {
          "20172018"=> 3,
          "20162017"=> 3.5
      }
      assert_equal expected , @stat_tracker.average_goals_by_season
  
    end

end
