require './test/test_helper'

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
      assert_equal 4.22,  @stat_tracker.average_goals_per_game
    end
    
    def test_it_can_average_goals_by_season
      expected = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
        }
      assert_equal expected , @stat_tracker.average_goals_by_season
  
    end

    def test_it_can_count_teams
      assert_equal 32, @stat_tracker.count_of_teams
    end
    
    def test_it_return_best_offense
      assert_equal "Reign FC", @stat_tracker.best_offense 
    end

    def test_it_can_return_worst_offense
      assert_equal "Utah Royals FC", @stat_tracker.worst_offense
    end

    def test_it_can_return_highest_scoring_visitor
      assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
    end

    def test_it_can_return_highest_scoring_home
      assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
    end
    
    def test_it_can_return_lowest_scoring_visitor
      assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
    end

    def test_it_can_return_lowest_scoring_home
      assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
    end

    def test_it_can_return_winningest_coach
  
      assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
      assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
    end

    def test_it_can_return_worst_coach
  
      assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
      assert_equal ("Craig MacTavish" || "Ted Nolan"), @stat_tracker.worst_coach("20142015")
    end

end
