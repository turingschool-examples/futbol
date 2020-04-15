require_relative 'test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      :games => @game_path,
      :teams => @team_path,
      :game_teams => @game_teams_path
                }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_csv_files
    assert_equal CSV.read(@game_path, headers: true, header_converters: :symbol), @stat_tracker.games
    assert_equal CSV.read(@team_path, headers: true, header_converters: :symbol), @stat_tracker.teams
    assert_equal CSV.read(@game_teams_path, headers: true, header_converters: :symbol), @stat_tracker.game_stats
  end

  def test_can_get_team_info
    expected = {"team_id"=>"9", "franchise_id"=>"30", "team_name"=>"New York City FC", "abbreviation"=>"NYC", "link"=>"/api/v1/teams/9"}
    assert_equal expected, @stat_tracker.team_info(9)
  end

  def test_can_get_most_goals_scored
    assert_equal 5, @stat_tracker.most_goals_scored(9)
  end

  def test_can_get_fewest_goals_scored
    assert_equal 0, @stat_tracker.fewest_goals_scored(9)
  end

  def test_can_average_win_percentage
    assert_equal 0.35, @stat_tracker.average_win_percentage(9)
  end

  def test_can_find_best_season
    assert_equal "20162017", @stat_tracker.best_season(9)
  end

  def test_can_find_worst_season
    assert_equal "20172018", @stat_tracker.worst_season(9)
  end

  def test_can_find_favorite_opponent
    assert_equal "FC Cincinnati", @stat_tracker.favorite_opponent(9)
  end

  def test_can_find_rival
    assert_equal "New England Revolution", @stat_tracker.rival(9)
  end

  def test_can_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_can_get_best_offense
    assert_equal "Reign FC", @stat_tracker.best_offense
  end

  def test_can_get_worst_offense
    assert_equal "Utah Royals FC", @stat_tracker.worst_offense
  end

  def test_can_get_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_can_get_highest_scoring__home_team
    assert_equal "Reign FC", @stat_tracker.highest_scoring_home_team
  end

  def test_can_get_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @stat_tracker.lowest_scoring_visitor
  end

  def test_can_get_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_get_highest_total_score
    assert_equal 8, @stat_tracker.highest_total_score
  end

  def test_if_it_can_get_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_if_it_can_get_percentage_home_wins
    assert_equal 0.67, @stat_tracker.percentage_home_wins
  end

  def test_if_it_can_get_percentage_visitor_wins
    assert_equal 0.33, @stat_tracker.percentage_visitor_wins
  end

  def test_if_it_can_get_percentage_ties
    assert_equal 0.0, @stat_tracker.percentage_ties
  end

  def test_if_it_can_get_count_of_games_by_season
    assert_equal ({"20122013"=>11, "20152016"=>3, "20142015"=>4}), @stat_tracker.count_of_games_by_season
  end

end
