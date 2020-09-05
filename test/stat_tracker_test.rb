require_relative 'test_helper'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end

  def test_it_exists
    stat_tracker = StatTracker.new(@locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_from_csv
    stat_tracker = StatTracker.new(@locations)

    assert stat_tracker.games
  end

  def test_games_has_game_data
    stat_tracker = StatTracker.new(@locations)

    assert stat_tracker.games.include?("2012030221")
    assert stat_tracker.games.include?("2017030317")
    assert stat_tracker.games.include?("2012030213")
  end


end
