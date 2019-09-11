require './test/test_helper'
require './lib/stat_tracker'
require './lib/leagueable'
require './lib/leagueable_helper'

class LeagueableHelperTest < Minitest::Test

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

  # def total_goals_helper
  # assert_equal , @stat_tracker.total_goals_helper
  # end
  #
  # def total_goals_allowed_helper
  # assert_equal , @stat_tracker.total_goals_allowed_helper
  # end
  #
  # def total_goals_at_home_helper
  # assert_equal , @stat_tracker.total_goals_at_home_helper
  # end
  #
  # def total_goals_visitor_helper
  # assert_equal , @stat_tracker.total_goals_visitor_helper
  # end

  def total_games_helper
  assert_equal , @stat_tracker.total_games_helper
  end

  def total_away_games_helper
  assert_equal , @stat_tracker.total_away_games_helper
  end

  def total_home_games_helper
  assert_equal , @stat_tracker.total_home_games_helper
  end

  def total_away_wins_helper
  assert_equal , @stat_tracker.total_away_wins_helper
  end

  def total_home_wins_helper
  assert_equal , @stat_tracker.total_home_wins_helper
  end

  def total_wins_helper
  assert_equal , @stat_tracker.total_wins_helper
  end

  def team_name_finder_helper
  assert_equal , @stat_tracker.team_name_finder_helper
  end

  def unique_home_teams_array_helper
  assert_equal , @stat_tracker.unique_home_teams_array_helper
  end

  def unique_away_teams_array_helper
  assert_equal , @stat_tracker.unique_away_teams_array_helper
  end

end
