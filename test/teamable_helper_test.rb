require './test/test_helper'
require './lib/stat_tracker'
require './lib/teamable'
require './lib/teamable_helper'

class TeamableHelperTest < Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  # def test_season_array_helper
  # assert_equal , @stat_tracker.season_array_helper
  # end
  #
  # def test_season_win_loss_helper
  # assert_equal , @stat_tracker.season_win_loss_helper
  # end
  #
  # def test_season_win_percentage_helper
  # assert_equal , @stat_tracker.season_win_percentage_helper
  # end
  #
  # #get games for a team_id
  # def test_games_for_team_helper
  # assert_equal , @stat_tracker.games_for_team_helper
  # end
  #
  # def test_total_wins_array_helper
  # assert_equal , @stat_tracker.total_wins_array_helper
  # end
  #
  # def test_total_games_array_helper
  # assert_equal , @stat_tracker.total_games_array_helper
  # end
end
