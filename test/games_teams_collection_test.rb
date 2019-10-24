require_relative 'test_helper'

class GamesTeamsCollectionTest < Minitest::Test

  def setup
    @games_teams_collection = GamesTeamsCollection.new('./data/dummy_games_teams.csv')
  end

  def test_it_exists
    assert_instance_of GamesTeamsCollection, @games_teams_collection
  end

  def test_it_initializes_attributes
    assert_equal 99, @games_teams_collection.games_teams.length
    assert_equal true, @games_teams_collection.games_teams.all? {|game_team| game_team.is_a?(GameTeam)}
  end

  def test_it_can_get_total_home_games
    assert_equal 49, @games_teams_collection.total_home_games
  end

  def test_it_can_get_home_wins
    assert_equal 32, @games_teams_collection.total_home_wins
  end

  def test_it_calculates_home_win_percentage_to_the_hundredths
    assert_equal 65.31, @games_teams_collection.percentage_home_wins
  end

  def test_it_has_max_goals
    assert_equal 4, @games_teams_collection.max_goals
  end

  def test_it_has_min_goals
    assert_equal 0, @games_teams_collection.min_goals
  end

  def test_it_has_a_big_blow_out
    assert_equal 4, @games_teams_collection.biggest_blowout
  end

  def test_it_can_get_total_away_games
    assert_equal 50, @games_teams_collection.total_away_games
  end

  def test_it_can_get_away_wins
    assert_equal 16, @games_teams_collection.total_away_wins
  end

  def test_it_calculates_away_win_percentage_to_the_hundredths
    assert_equal 32.00, @games_teams_collection.percentage_visitor_wins
  end

  def test_it_can_get_total_ties
    assert_equal 2, @games_teams_collection.total_ties
  end

  def test_it_calculates_percentage_ties
    assert_equal 2.02, @games_teams_collection.percentage_ties
  end
end
