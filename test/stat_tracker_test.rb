require "./test/test_helper.rb"
class StatTrackerTest < MiniTest::Test

  def test_it_exists
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stattracker1 = StatTracker.from_csv(locations)
    assert_instance_of StatTracker, stattracker1
  end

  def test_it_has_attributes
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    require "pry"; binding.pry
    assert_equal CSV::Table, stat_tracker.games.class
    assert_equal CSV::Table, stat_tracker.seasons.class
  end

  def test_it_can_calculate_games_coached_per_coach
    game_path = './data/fake_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/fake_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }
      stat_tracker = StatTracker.from_csv(locations)
      assert_equal 3, stat_tracker.games_coached("20132014")["Peter Horachek"]
    end

    def test_it_can_calculate_games_won_per_coach
      game_path = './data/fake_games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/fake_game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      assert_equal 1, stat_tracker.games_won("20132014")["Peter Horachek"]
    end

    def test_it_can_calculate_winning_percentage_per_coach
      game_path = './data/fake_games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/fake_game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      assert_equal 0.333, stat_tracker.winning_percentage("20132014")["Peter Horachek"]
    end

    def test_if_it_can_get_coach_with_highest_win_percent
      game_path = './data/fake_games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/fake_game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
      stat_tracker = StatTracker.from_csv(locations)
      assert_equal "Claude Noel", stat_tracker.winningest_coach("20132014")
    end

  end
