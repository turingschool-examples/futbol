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

    stat_tracker = StatTracker.from_csv(locations)
    assert_instance_of StatTracker, stat_tracker
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
    assert_equal './data/games.csv', stat_tracker.games_data
  end

  def test_it_can_generate_games
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    stat_tracker.generate_games
    assert_equal 7441, stat_tracker.games.count
    require "pry"; binding.pry
  end



end
