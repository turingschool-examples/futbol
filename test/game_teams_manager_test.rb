require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_teams_manager'
require './lib/game_team'
require 'pry';
require 'mocha/minitest'

class GameTeamsManagerTest < Minitest::Test
  def setup
    game_path = './data/dummy_game.csv'
    team_path = './data/dummy_teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    stat_tracker = StatTracker.from_csv(locations)
    @game_teams_manager = GameTeamsManager.new(game_teams_path, stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_return_games_played_by_team
    assert_equal 7, @game_teams_manager.games_played('6').count
  end

  def test_return_total_goals_by_team
    assert_equal 20, @game_teams_manager.total_goals('6')
  end

  def test_average_number_of_goals_scored_by_team
    assert_equal 2.86, @game_teams_manager.average_number_of_goals_scored_by_team('6')
  end

  def test_return_games_played_by_type
    assert_equal 3, @game_teams_manager.games_played_by_type('3', 'away').count
    assert_equal 3, @game_teams_manager.games_played_by_type('3', 'home').count
  end

  def test_return_total_goals_by_type
    assert_equal 5, @game_teams_manager.total_goals_by_type('3', 'away')
    assert_equal 4, @game_teams_manager.total_goals_by_type('3', 'home')
  end

  def test_average_number_of_goals_scored_by_team_by_type
    assert_equal 1.67, @game_teams_manager.average_number_of_goals_scored_by_team_by_type('3', 'away')
    assert_equal 1.33, @game_teams_manager.average_number_of_goals_scored_by_team_by_type('3', 'home')
  end

  def test_it_can_find_winningest_coach
    season_id = '20152016'
    assert_equal 'Mike Sullivan', @game_teams_manager.winningest_coach(season_id)
  end

  def test_it_can_find_season_id
    game_id = '2012030221'
    assert_equal '20122013', @game_teams_manager.find_season_id(game_id)
  end

  def test_coaches_hash_w_avg_win_percentage

  end

  def test_average_win_percentage

  end

  def test_games_for_coach

  end

  def test_wins_for_coach

  end

  def test_selected_season_game_teams

  end

end
