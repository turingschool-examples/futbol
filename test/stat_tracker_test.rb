require_relative '../test/testhelper'
require_relative '../lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @stat_tracker = StatTracker.from_csv({ :games => "./test/fixtures/games_trunc.csv", :teams => "./test/fixtures/teams_trunc.csv", :game_teams => "./test/fixtures/game_teams_trunc.csv"})
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    assert_equal "./test/fixtures/games_trunc.csv", @stat_tracker.games_path
    assert_equal "./test/fixtures/teams_trunc.csv", @stat_tracker.teams_path
    assert_equal "./test/fixtures/game_teams_trunc.csv", @stat_tracker.game_teams_path
  end

  def test_it_can_create_a_games_teams_collection
    assert_instance_of GameTeamsCollection, @stat_tracker.game_teams_collection
  end

  def test_it_can_create_a_games_collection
    assert_instance_of GamesCollection, @stat_tracker.games_collection
  end

  def test_it_can_create_a_teams_collection
    assert_instance_of TeamsCollection, @stat_tracker.teams_collection
  end

  def test_best_offense
    assert_equal "DC United", @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal "New England Revolution", @stat_tracker.worst_offense

  end

  def test_highest_scoring_visitor
    assert_equal "FC Dallas", @stat_tracker.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal "Seattle Sounders FC", @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    assert_equal "Houston Dynamo", @stat_tracker.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    assert_equal "New England Revolution", @stat_tracker.lowest_scoring_home_team
  end

  # def test_biggest_bust
  #   assert_equal "Montreal Impact", @stat_tracker.biggest_bust("20132014")
  # end
  #
  # def test_biggest_surprise
  #    assert_equal "FC Cincinnati", @stat_tracker.biggest_surprise("20132014")
  # end
  #
  # def test_winningest_coach
  #   assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
  # end
  #
  # def test_worst_coach
  #   assert_equal "Ted Nolan", @stat_tracker.worst_coach("20142015")
  # end

  def test_head_to_head
    assert_equal ({"Portland Timbers"=>0.5}), @stat_tracker.head_to_head("15")
  end

  def test_team_info
    expected = {"team_id"=>"7", "franchise_id"=>"19", "team_name"=>"Utah Royals FC",
      "abbreviation"=>"URF", "link"=>"/api/v1/teams/7"}

    assert_equal expected, @stat_tracker.team_info("7")
  end

  def test_best_season
    assert_equal "20122013", @stat_tracker.best_season("6")
  end

  def test_average_win_percentage
   assert_equal 1.0, @stat_tracker.average_win_percentage("6")
  end

  def test_most_goals_scored
   assert_equal 3, @stat_tracker.most_goals_scored("18")
  end

  def test_fewest_goals_scored
    assert_equal 1, @stat_tracker.fewest_goals_scored("18")
  end

  def test_favorite_opponent
    assert_equal "Orlando City SC", @stat_tracker.favorite_opponent("18")
  end

  def test_rival
    assert_equal "Chicago Red Stars", @stat_tracker.rival("18")
  end

end
