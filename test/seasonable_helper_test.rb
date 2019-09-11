require './test/test_helper'
require './lib/stat_tracker'
require './lib/seasonable'
require './lib/seasonable_helper'

class SeasonableHelperTest < Minitest::Test

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
  def regular_season_win_percentage_helper
    assert_equal , @stat_tracker.regular_season_win_percentage_helper
  end

  def postseason_win_percentage_helper
    assert_equal , @stat_tracker.postseason_win_percentage_helper
  end

  def coach_win_percentage_helper
    assert_equal , @stat_tracker.coach_win_percentage_helper
  end

  def coach_array_helper
    assert_equal , @stat_tracker.coach_array_helper
  end

  def season_converter
    assert_equal , @stat_tracker.season_converter
  end

  def shots_helper
    assert_equal , @stat_tracker.shots_helper
  end

  def goals_helper
    assert_equal , @stat_tracker.goals_helper
  end

  def tackles_helper
    assert_equal , @stat_tracker.tackles_helper
  end
end
