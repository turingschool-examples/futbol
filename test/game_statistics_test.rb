require_relative 'test_helper'

class GameStatisticsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  @stat_tracker = StatTracker.from_csv(locations)
  @game_statistics = GameStatistics.new('./data/games.csv', @stat_tracker)
  end

  def test_it_exists
    assert_instance_of GameStatistics, @game_statistics
  end

  def test_it_has_attributes
    assert_equal 7441, @game_statistics.game_data.length
  end

  def test_knows_total_games_count
    assert_equal 7441, @game_statistics.total_games
  end

  def test_it_can_get_all_scores_by_game_id
    assert_equal 7441, @game_statistics.get_all_scores_by_game_id.length
  end

  def test_it_can_find_highest_total_score
    assert_equal 11, @game_statistics.highest_total_score
  end

  def test_it_can_find_lowest_total_score
    assert_equal 0, @game_statistics.lowest_total_score
  end

  def test_knows_all_home_wins
    assert_equal 3237, @game_statistics.all_home_wins.length
  end

  # def test_it_knows_percentage_home_wins
  #   assert_equal 0.44, @game_statistics.percentage_home_wins
  # end

  # def test_it_knows_all_visitor_wins
  #   assert_equal 2687, @game_statistics.all_visitor_wins.length
  # end
  #
  # def test_it_knows_percentage_visitor_wins
  #   assert_equal 0.36, @game_statistics.percentage_visitor_wins
  # end
  #
  # def test_it_knows_count_of_ties
  #   assert_equal 1517, @game_statistics.count_of_ties
  # end
  #
  # def test_it_knows_percentage_ties
  #   assert_equal 0.20, @game_statistics.percentage_ties
  # end
  #
  def test_can_get_hash_of_seasons
    assert_equal 6, @game_statistics.hash_of_seasons.keys.count
  end

  def test_it_knows_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @game_statistics.count_of_games_by_season
  end

  def test_knows_average_goals_per_game
    assert_equal 4.22, @game_statistics.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }

      assert_equal expected, @game_statistics.average_goals_by_season
  end
end
