require_relative 'test_helper'

class GameStatsCollectionTest < Minitest::Test
  def setup
    @game_stats_collection = GameStatsCollection.new("./test/fixtures/truncated_game_teams.csv")
    @game_stats = @game_stats_collection.game_stats[0]
  end

  def test_it_exists
    assert_instance_of GameStatsCollection, @game_stats_collection
  end

  def test_it_has_attributes
    assert_instance_of Array, @game_stats_collection.game_stats
    assert_equal 12, @game_stats_collection.game_stats.length
  end

  def test_it_can_create_game_stats_from_csv
    assert_instance_of GameStats, @game_stats
    assert_equal 2012030221, @game_stats.game_id
    assert_equal 3, @game_stats.team_id
    assert_equal "away", @game_stats.home_away
    assert_equal "LOSS", @game_stats.result
    assert_equal "OT", @game_stats.settled_in
    assert_equal "John Tortorella", @game_stats.head_coach
    assert_equal 2, @game_stats.goals
    assert_equal 8, @game_stats.shots
    assert_equal 44, @game_stats.tackles
    assert_equal 8, @game_stats.pim
    assert_equal 3, @game_stats.power_play_opportunities
    assert_equal 0, @game_stats.power_play_goals
    assert_equal 44.8, @game_stats.face_off_win_percentage
    assert_equal 17, @game_stats.giveaways
    assert_equal 7, @game_stats.takeaways
  end

  def test_goals_by_team_id
    result = {3=>[2, 2, 1, 2, 1], 6=>[3, 2, 3, 3, 3, 4], 5=>[0]}
    assert_equal result, @game_stats_collection.goals_by_team_id("all")

    result2 = {3=>[2, 2, 1], 6=>[2, 3, 3, 4]}
    assert_equal result2, @game_stats_collection.goals_by_team_id("away")

    result3 = {6=>[3, 3], 3=>[1, 2], 5=>[0]}
    assert_equal result3, @game_stats_collection.goals_by_team_id("home")
  end

  def test_average_goals_by_team_id
    result = {3=>1.6, 6=>3.0, 5=>0.0}
    assert_equal result, @game_stats_collection.average_goals_by_team_id("all")
  end

  def test_find_team_id
    assert_equal 6, @game_stats_collection.find_team_id("all", "max")
    assert_equal 5, @game_stats_collection.find_team_id("all", "min")
  end

  def test_find_team_name_by_id
    assert_equal "FC Dallas", @game_stats_collection.find_team_name_by_team_id(6)
  end

  def test_best_offense
    assert_equal "FC Dallas", @game_stats_collection.best_offense
  end

  def test_worst_offense
    assert_equal "Sporting Kansas City", @game_stats_collection.worst_offense
  end

  def test_average_away_goals_by_team_id
    skip
    result = {3=>1.67, 6=>3.0}
    assert_equal result, @game_stats_collection.average_away_goals_by_team_id
  end

  def test_highest_scoring_visitor_id
    skip
    assert_equal 6, @game_stats_collection.highest_scoring_visitor_id
  end

  def test_highest_scoring_visitor
    skip
    assert_equal "FC Dallas", @game_stats_collection.highest_scoring_visitor
  end

  def test_home_goals_by_team_id
    skip
    result = {6=>[3, 3], 3=>[1, 2], 5=>[0]}
    assert_equal result, @game_stats_collection.home_goals_by_team_id
  end

  def test_average_home_goals_by_team_id
    skip
    result = {6 => 3.00, 3 => 1.50, 5 => 0}
    assert_equal result, @game_stats_collection.average_home_goals_by_team_id
  end

  def test_highest_scoring_home_team_id
    skip
    assert_equal 6, @game_stats_collection.highest_scoring_home_team_id
  end

  def test_highest_scoring_home_team
    skip
    assert_equal "FC Dallas", @game_stats_collection.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor_id
    skip
    assert_equal 3, @game_stats_collection.lowest_scoring_visitor_id
  end

  def test_lowest_scoring_visitor
    skip
    assert_equal "Houston Dynamo", @game_stats_collection.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team_id
    skip
    assert_equal 5, @game_stats_collection.lowest_scoring_home_team_id
  end

  def test_lowest_scoring_home_team
    skip
    assert_equal "Sporting Kansas City", @game_stats_collection.lowest_scoring_home_team
  end

  def test_can_find_all_games_for
    assert_equal 6, @game_stats_collection.all_games_for(6).count
  end

  def test_can_get_most_goals_by_team_id
    assert_equal 4, @game_stats_collection.most_goals_scored(6)
  end

  def test_can_find_fewest_goals_by_team_id
    assert_equal 2, @game_stats_collection.fewest_goals_scored(6)
  end

  def test_can_calculate_average_win_percentage
    assert_equal 1.0, @game_stats_collection.average_win_percentage(6)
  end
end
