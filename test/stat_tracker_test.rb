require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @game_path = './data/dummy_game_path.csv'
    @team_path = './data/dummy_team_path.csv'
    @game_teams_path = './data/dummy_game_teams_path.csv'


    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_read_from_games_file
    assert_equal "Postseason", @stat_tracker.games[0]["type"]
    assert_equal "Toyota Stadium", @stat_tracker.games[1]["venue"]
  end

  def test_read_from_teams_file
    assert_equal "Atlanta United", @stat_tracker.teams[0]["teamName"]
    assert_equal "SeatGeek Stadium", @stat_tracker.teams[1]["Stadium"]
  end

  def test_read_from_game_teams_file
    assert_equal "8", @stat_tracker.game_teams[0]["shots"]
    assert_equal "55.2", @stat_tracker.game_teams[1]["faceOffWinPercentage"]
  end

  # ************* LeagueStatistics Tests *************

  def test_get_number_of_teams
    assert_equal 3, @stat_tracker.count_of_teams
  end

  def test_get_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  # ************* SeasonStatistics Tests *************

  def test_total_games_played_by_coach_helper

    expected = {"John Tortorella"=>5, "Claude Julien"=>9, "Dan Bylsma"=>4, "Mike Babcock"=>1}


    assert_equal expected, @stat_tracker.total_games_played_by_coach_helper
  end

  def test_total_games_won_by_coach_array_helper
    assert_equal ["Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien", "Claude Julien",], @stat_tracker.total_games_won_by_coach_array_helper
  end

  def test_games_won_into_hash_helper

    expected = {"Claude Julien"=>9}

    assert_equal expected, @stat_tracker.games_won_into_hash_helper
  end

  def test_coaches_with_games_played_and_won_array_helper

    assert_equal ["Claude Julien"], @stat_tracker.coaches_with_games_played_and_won_array_helper

  end

  def test_coaches_winning_percentage_hash_helper

    expected = {"Claude Julien"=>100}

    assert_equal expected , @stat_tracker.coaches_winning_percentage_hash_helper
  end

  def test_name_of_coach_with_highest_win_percentage

    assert_equal ["Claude Julien"], @stat_tracker.coach_with_highest_win_percentage

  end
end
