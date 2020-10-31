require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'
require './lib/stat_tracker'
require 'mocha/minitest'

class GameCollectionTest < Minitest::Test
  def setup
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }

    stat_tracker     = mock('stat_tracker')
    @game_collection = GameCollection.new(game_path, stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameCollection, @game_collection
  end

  def test_scores_by_game
    assert_equal 7441, @game_collection.scores_by_game.count
  end

  def test_it_calls_highest_total_score
    assert_equal 11, @game_collection.highest_total_score
  end

  def test_it_calls_lowest_total_score
    assert_equal 0, @game_collection.lowest_total_score
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>806, "20162017"=>1317, "20142015"=>1319, "20152016"=>1321, "20132014"=>1323, "20172018"=>1355}
    assert_equal expected, @game_collection.count_of_games_by_season
  end

  def test_total_games
    assert_equal 7441, @game_collection.total_games
  end

  def test_average_goals_per_game
    assert_equal 4.22, @game_collection.average_goals_per_game
  end

  def test_sum_of_scores_by_season
    expected = {"20122013"=>3322, "20162017"=>5565, "20142015"=>5461, "20152016"=>5499, "20132014"=>5547, "20172018"=>6019}
    assert_equal expected, @game_collection.sum_of_scores_by_season
  end

  def test_season_id
    assert_equal [20162017, 20142015, 20132014], @game_collection.season_id
  end

  # def test_average_goals_by_season
  #   expected = {20122013 => 2.53}
  #   assert_equal expected, @game_collection.average_goals_by_season
  # end

end
