require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/games_dummy.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    our_locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

   @stat_tracker = StatTracker.from_csv(our_locations)
 end

  def test_it_exists
    skip
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    skip
    assert_instance_of Array, @stat_tracker.games
    assert_instance_of Game, @stat_tracker.games[0]
    assert_instance_of Array, @stat_tracker.teams
    assert_instance_of Team, @stat_tracker.teams[0]
    assert_equal './data/game_teams_dummy.csv', @stat_tracker.game_teams
  end

  def test_it_can_calculate_highest_total_score
    skip
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    skip
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_calculate_biggest_blowout
    skip
    assert_equal 5, @stat_tracker.biggest_blowout
  end

  def test_it_can_calculate_percentage_home_wins
    skip
    assert_equal 0.53, @stat_tracker.percentage_home_wins
  end

  def test_it_can_calculate_percentage_visitor_wins
    skip
    assert_equal 0.41, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_calculate_percentage_ties
    skip
    assert_equal 0.06, @stat_tracker.percentage_ties
  end

  def test_it_can_count_games_by_season
    skip
    assert_equal ({20122013 => 5, 20142015 => 12, 20152016 => 1, 20172018 => 9, 20132014=>4, 20162017=>1}), @stat_tracker.count_of_games_by_season
  end

  def test_it_calculate_average_goals_per_game
    skip
    assert_equal 4.13, @stat_tracker.average_goals_per_game
  end

  def test_it_calculate_average_goals_per_season
    skip
    assert_equal ({20122013 => 4.6, 20142015 => 3.84, 20152016 => 3.0, 20172018 => 4.33, 20132014=>4.0, 20162017=>5.0}), @stat_tracker.average_goals_by_season
  end

  def test_count_of_teams
    skip
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_finds_team_with_best_offense
    skip
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_finds_team_with_worst_offense
    skip
    assert_equal "North Carolina Courage", @stat_tracker.worst_offense
  end

  def test_finds_team_with_best_defense
    skip
    assert_equal "North Carolina Courage", @stat_tracker.best_defense
  end

  def test_finds_team_with_worst_defense
    skip
    assert_equal "Los Angeles FC", @stat_tracker.worst_defense
  end

  def test_finds_team_with_highest_scoring_visitor
    skip
    assert_equal "North Carolina Courage", @stat_tracker.highest_scoring_visitor
  end

  def test_finds_team_with_highest_scoring_home_team
    skip
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_finds_team_with_lowest_scoring_home_team
    skip
    assert_equal "North Carolina Courage", @stat_tracker.lowest_scoring_home_team
  end

  def test_finds_team_with_lowest_scoring_visitor
    skip
    assert_equal "Los Angeles FC", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_determine_winningest_team_across_all_seasons
    skip
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_it_can_determine_best_fans
    skip
    assert_equal "LA Galaxy", @stat_tracker.best_fans
  end

  def test_it_can_determine_worst_fans
    skip
    assert_equal ["Sporting Kansas City", "Seattle Sounders FC"], @stat_tracker.worst_fans
  end

  def test_can_find_biggest_bust
    assert_equal "Real Salt Lake", @stat_tracker.biggest_bust("20162017")
  end
end
