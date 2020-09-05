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
    stat_tracker = StatTracker.from_csv(@locations)

    assert_instance_of StatTracker, stat_tracker
  end

  def test_games_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.games.include?("2012030221")
    stat = StatTracker.from_csv(@locations)
    assert stat.games.include?("2017030317")
    assert stat.games.include?("2012030213")
  end

  def test_teams_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.teams.include?("4")
    assert stat.teams.include?("26")
    stat = StatTracker.from_csv(@locations)
    assert stat.teams.include?("14")
  end

  def test_teams_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.game_teams.include?("2012030221")
    stat = StatTracker.from_csv(@locations)
    assert stat.game_teams.include?("2012030222")
    assert stat.game_teams.include?("2012030224")
  end


end
