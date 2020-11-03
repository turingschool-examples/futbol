require './test/test_helper'

class GameTeamGameTest < Minitest::Test
  def setup
    game_path       = './data/games_dummy.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path,
                }

    @stat_tracker         = StatTracker.from_csv(locations)
    @game_team_game = GameTeamGame.new(game_teams_path, @stat_tracker)
  end

  def test_compare_hoa_to_result
    assert_equal 54.0, @game_team_game.compare_hoa_to_result("home", "WIN")
  end

  def test_total_amount_games
    assert_equal 100, @game_team_game.total_amount_games
  end

  def test_it_calls_percentage_of_games_w_home_team_win
    assert_equal 54.0, @game_team_game.percentage_home_wins
  end

  def test_it_calls_percentage_of_games_w_visitor_team_win
    assert_equal 43.0, @game_team_game.percentage_visitor_wins
  end

  def test_it_calls_percentage_of_games_tied
    assert_equal 3.0, @game_team_game.percentage_ties
  end

  def test_total_percentages_equals_100
    @game_team_game.stubs(:percentage_home_wins).returns(54.0)
    @game_team_game.stubs(:percentage_visitor_wins).returns(43.0)
    @game_team_game.stubs(:percentage_ties).returns(3.0)
    assert_equal 100, (@game_team_game.percentage_home_wins +
                       @game_team_game.percentage_visitor_wins +
                       @game_team_game.percentage_ties)
  end

end
