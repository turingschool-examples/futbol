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
end
