require_relative 'test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @stat_tracker ||= StatTracker.new({games: game_path, teams: team_path,
      game_teams: game_teams_path})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_from_csv
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_games_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.game_table.include?("2012030221")
    assert @stat_tracker.game_table.include?("2017030317")
    assert @stat_tracker.game_table.include?("2012030213")
  end

  def test_teams_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.team_table.include?("4")
    assert @stat_tracker.team_table.include?("26")
    assert @stat_tracker.team_table.include?("14")
  end

  def test_game_teams_has_game_data
    stat = StatTracker.new
    assert_equal false, stat.game_team_table.include?("2012030221")
    @stat_tracker.game_team_table.find do |game|
    assert_equal true, game.game_id == 2012030221
    end
  end
  
end
