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

    @stat_tracker    = StatTracker.from_csv(locations)
    @game_collection = GameCollection.new(game_path, @stat_tracker)
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
    assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"], @game_collection.season_id
  end

  def test_average_goals_by_season
    expected = {"20122013"=>4.12, "20162017"=>4.23, "20142015"=>4.14, "20152016"=>4.16, "20132014"=>4.19, "20172018"=>4.44}
    assert_equal expected, @game_collection.average_goals_by_season
  end

   def test_game_ids_per_season
      expected = {"20122013"=> ["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314", "2012030231", "2012030232", "2012030233", "2012030234", "2012030235", "2012030236", "2012030237", "2012030121", "2012030122", "2012030123", "2012030124", "2012030125", "2012030151", "2012030152", "2012030153", "2012030154", "2012030155", "2012030181", "2012030182", "2012030183", "2012030184", "2012030185", "2012030186", "2012030161", "2012030162", "2012030163", "2012030164", "2012030165", "2012030166", "2012030167", "2012030111", "2012030112", "2012030113", "2012030114", "2012030115", "2012030116", "2012030131", "2012030132", "2012030133", "2012030134", "2012030135", "2012030136", "2012030137", "2012030321", "2012030322"], "20162017"=>["2016030165"], "20152016"=>["2015030311"]}
      assert_equal 6, @game_collection.game_ids_per_season.count
  end

  # LeagueStatistics
  def test_it_knows_total_games_per_team_id_away
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    assert_equal 32, @game_collection.total_games_per_team_id_away.count
  end

  def test_it_knows_total_games_per_team_id_home
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    assert_equal 32, @game_collection.total_games_per_team_id_home.count
  end

  def test_it_knows_total_goals_per_team_id_away
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    assert_equal 32, @game_collection.total_goals_per_team_id_away.count
  end

  def test_it_knows_total_goals_per_team_id_home
    # expected = {"6"=>12.0, "3"=>3.0, "5"=>1.0, "24"=>6.0, "20"=>3.0}
    assert_equal 32, @game_collection.total_goals_per_team_id_home.count
  end
end
