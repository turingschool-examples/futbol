require_relative 'test_helper'
require './lib/modules/gatherable'
require './lib/modules/calculateable'
require './lib/tracker'
require './lib/stat_tracker'

class CalculateableTest < Minitest::Test
  include Gatherable
  include Calculateable

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = Tracker.from_csv(locations)
  end

  def test_calculateable_exists
    calculateable = Calculateable

    assert_equal Calculateable, calculateable
  end

  def team_average_goals(goals_hash)
    average_goals = {}
    goals_hash.each do |team, tot_score|
      average_goals[team] = (tot_score.to_f / games_by_team[team]).round(2)
    end

    average_goals
  end

  def test_calculateable_can_return_team_win_percentage
    # assert_instance_of DATA, @stat_tracker.team_win_percentage(wins_hash)
  end

  def test_calculateable_can_return_season_coach_win_percent
    # assert_instance_of DATA, @stat_tracker.season_coach_win_percent(wins_hash, season_id)
  end

  def test_calculateable_can_return_team_away_average_wins
    # assert_instance_of DATA, @stat_tracker.team_away_average_wins(wins_hash)
  end

  def test_calculateable_can_return_combine_game_data
    assert_instance_of Hash, @stat_tracker.combine_game_data
    assert_equal 14882, @stat_tracker.combine_game_data.size
  end

  def test_calculateable_can_return_league_win_percent_diff
    # assert_instance_of DATA, @stat_tracker.league_win_percent_diff(home, away)
  end

  def test_calculateable_can_return_win_percentage_increase
    # assert_instance_of DATA, @stat_tracker.win_percentage_increase(regular, post)
  end

  def test_calculateable_can_return_worst_team_helper
    # assert_instance_of DATA, @stat_tracker.worst_team_helper(home, away)
  end

  # def test_calculateable_can_return_team_postseason_win_percent
    # assert_instance_of DATA, @stat_tracker.team_postseason_win_percent(wins_hash)
  # end

  # def test_calculateable_can_return_team_home_average_wins
    # assert_instance_of DATA, @stat_tracker.team_home_average_wins(wins_hash)
  # end

  # def test_calculateable_can_return_team_total_seasons
    # assert_instance_of Integer, @stat_tracker.team_total_seasons('6')
  # end

  # def test_calculateable_can_return_team_season_keys
    # assert_instance_of Hash, @stat_tracker.team_season_keys('6')
  # end

  # def test_calculateable_can_return_create_season
    # assert_instance_of DATA, @stat_tracker.create_season
  # end

  # def test_calculateable_can_return_win_percentage_difference
    # assert_instance_of DATA, @stat_tracker.win_percentage_difference(regular, post)
  # end
end
