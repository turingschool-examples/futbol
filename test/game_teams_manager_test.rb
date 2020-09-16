require "./test/test_helper"
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
    season_id = '20152016'
    expected = {'Mike Sullivan' => 1.0, 'Alain Vigneault' => 0.0}
    assert_equal expected, @game_teams_manager.coaches_hash_avg_win_pct(season_id)
  end

  def test_games_for_coach
    season_id = '20152016'
    head_coach = 'Mike Sullivan'
    assert_equal 1, @game_teams_manager.games_for_coach(season_id, head_coach)
  end

  def test_wins_for_coach
    season_id = '20152016'
    head_coach = 'Mike Sullivan'
    assert_equal 1, @game_teams_manager.wins_for_coach(season_id, head_coach)
  end

  def test_selected_season_game_teams
    season_id = '20152016'
    assert_equal 2, @game_teams_manager.selected_season_game_teams(season_id).count
  end

  def test_it_can_find_worst_coach
    season_id = '20122013'
    assert_equal 'John Tortorella', @game_teams_manager.worst_coach(season_id)
  end

  def test_shots_by_team
    season_id = '20122013'
    team_num = '3'
    assert_equal 38, @game_teams_manager.shots_by_team(season_id, team_num)
  end

  def test_goals_by_team
    season_id = '20122013'
    team_num = '3'
    assert_equal 8, @game_teams_manager.goals_by_team(season_id, team_num)
  end

  def test_teams_hash_w_ratio_shots_goals
    season_id = '20122013'
    expected = {
                  '3' => 0.2105,
                  '6' => 0.3333,
                  '5' => 0.0769
    }
    assert_equal expected, @game_teams_manager.teams_hash_shots_goals(season_id)
  end

  def test_most_accurate_team
    season_id = '20122013'
    assert_equal '6', @game_teams_manager.most_accurate_team(season_id)
  end

  def test_least_accurate_team
    season_id = '20122013'
    assert_equal '5', @game_teams_manager.least_accurate_team(season_id)
  end

  def test_tackles_by_team
    season_id = '20122013'
    team_num = '3'
    assert_equal 179, @game_teams_manager.tackles_by_team(season_id, team_num)
  end

  def test_teams_hash_w_tackles
    season_id = '20122013'
    expected = {
                  '3' => 179,
                  '6' => 212,
                  '5' => 71
    }
    assert_equal expected, @game_teams_manager.teams_hash_w_tackles(season_id)
  end

  def test_most_tackles
    season_id = '20122013'
    assert_equal '6', @game_teams_manager.most_tackles(season_id)
  end

  def test_fewest_tackles
    season_id = '20122013'
    assert_equal '5', @game_teams_manager.fewest_tackles(season_id)
  end

  def test_it_can_find_best_season_for_team
    team_id = '6'
    assert_equal '20122013', @game_teams_manager.get_best_season(team_id)
  end

  def test_it_can_find_worst_season_for_team
    team_id = '6'
    assert_equal '20122013', @game_teams_manager.get_worst_season(team_id)
  end

  def test_it_can_find_average_win_percentage_for_team
    team_id = '6'
    assert_equal 0.86, @game_teams_manager.get_average_win_pct(team_id)
  end

  def test_it_can_get_most_goals_scored_for_team
    team_id = '6'
    assert_equal 4, @game_teams_manager.get_most_goals_scored_for_team(team_id)
  end

  def test_it_can_get_fewest_goals_scored_for_team
    team_id = '6'
    assert_equal 1, @game_teams_manager.get_fewest_goals_scored_for_team(team_id)
  end

  def test_it_can_get_favorite_opponent
    team_id = '6'
    assert_equal '3', @game_teams_manager.get_favorite_opponent(team_id)
  end

  def test_it_can_get_rival
    team_id = '6'
    assert_equal '3', @game_teams_manager.get_rival(team_id)
  end
end
