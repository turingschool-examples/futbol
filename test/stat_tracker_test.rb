require_relative 'test_helper'
require_relative '../lib/stat_tracker'


class StatTrackerTest < Minitest::Test
  def setup
    file_paths = {
                  games: './data/dummy_games.csv',
                  teams: './data/dummy_teams.csv',
                  game_teams: './data/dummy_games_teams.csv'
                }
    @stat_tracker = StatTracker.from_csv(file_paths)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_initializes_with_attributes
    assert_instance_of GamesCollection, @stat_tracker.games
    assert_instance_of TeamsCollection, @stat_tracker.teams
    assert_instance_of GamesTeamsCollection, @stat_tracker.games_teams
  end

  # Begin tests for iteration-required methods

  def test_it_grabs_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_grabs_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_has_a_big_blow_out
    assert_equal 4, @stat_tracker.biggest_blowout
  end

  def test_it_calculates_home_win_percentage_to_the_hundredths
    assert_equal 0.65, @stat_tracker.percentage_home_wins
  end

  def test_it_calculates_away_win_percentage_to_the_hundredths
    assert_equal 0.32, @stat_tracker.percentage_visitor_wins
  end

  def test_it_calculates_percentage_ties
    assert_equal 0.02, @stat_tracker.percentage_ties
  end

  def test_it_can_count_game_by_season

    expected = {
      "20122013" => 57,
      "20162017" => 4,
      "20142015" => 16,
      "20152016" => 16,
      "20132014" => 6
    }

    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_it_can_calculate_average_goals_per_game
    assert_equal 3.91, @stat_tracker.average_goals_per_game
  end

  def test_it_can_return_hash_of_average_goals_by_season
    expected_hash = {
                      "20122013"=>3.86,
                      "20162017"=>4.75,
                      "20142015"=>3.75,
                      "20152016"=>3.88,
                      "20132014"=>4.33
                    }
    assert_equal expected_hash, @stat_tracker.average_goals_by_season
  end

  def test_it_knows_how_many_teams_there_are
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_get_name_of_team_by_id
    assert_equal "FC Dallas", @stat_tracker.name_of_team("6")
    assert_equal "Los Angeles FC", @stat_tracker.name_of_team("28")
  end

  def test_it_can_tell_name_of_highest_scoring_home_team
    assert_equal "New York City FC", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_tell_name_of_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_it_can_tell_name_of_lowest_scoring_home_team
    assert_equal "Chicago Fire", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_tell_name_of_lowest_scoring_visitor
    assert_equal "Seattle Sounders FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_find_name_of_winningest_team
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_it_can_find_team_with_best_fans
    assert_equal "New England Revolution", @stat_tracker.best_fans
  end

  def test_it_can_find_names_of_teams_with_worst_fans
    # no such teams exist in fixture data, but 2 exist in real data
    assert_equal [], @stat_tracker.worst_fans
  end
end
