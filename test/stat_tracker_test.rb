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
      skip
      games = mock
      games.stubs(:make_games).returns(Game)

      assert_equal Game, @stat_tracker.make_games
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

end
