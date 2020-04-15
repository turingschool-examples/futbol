require 'simplecov'
SimpleCov.start

require "minitest/autorun"
require "minitest/pride"
require "./lib/game"
require "pry"
require "mocha/minitest"
require './lib/collection'

class GameTest < Minitest::Test

  def setup
    @base_game = Game.new({:game_id => 123,
                :season => 456,
                :type => "good",
                :date_time => "12/20/20",
                :away_team_id => 45,
                :home_team_id => 36,
                :away_goals => 3,
                :home_goals => 3,
                :venue => "Heaven",
                :venue_link => "venue/link"})

    Game.from_csv('./test/fixtures/games_20.csv', Game)
    @game = Game.all[0]
  end

  def test_it_exists
    assert_instance_of Game, @base_game
  end

  def test_it_has_attributes
    assert_equal 123, @base_game.game_id
    assert_equal 456, @base_game.season
    assert_equal "good", @base_game.type
    assert_equal "12/20/20", @base_game.date_time
    assert_equal 45, @base_game.away_team_id
    assert_equal 36, @base_game.home_team_id
    assert_equal 3, @base_game.away_goals
    assert_equal 3, @base_game.home_goals
    assert_equal "Heaven", @base_game.venue
    assert_equal "venue/link", @base_game.venue_link
  end

  def test_it_can_create_game_from_csv
    assert_equal "2012030221", @game.game_id
    assert_equal "20122013", @game.season
    assert_equal "Postseason", @game.type
    assert_equal "5/16/13", @game.date_time
    assert_equal "3", @game.away_team_id
    assert_equal "6", @game.home_team_id
    assert_equal 2, @game.away_goals
    assert_equal 3, @game.home_goals
    assert_equal "Toyota Stadium", @game.venue
    assert_equal "/api/v1/venues/null", @game.venue_link
  end

  def test_it_has_all
    assert_instance_of Array, Game.all
    assert_equal 20, Game.all.length
    assert_instance_of Game, Game.all.first
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 5, Game.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 3, Game.lowest_total_score
  end
#deliverable
  def test_it_returns_average_goals_per_game
    assert_equal 4.4, Game.average_goals_per_game
    game1 = mock
    game2 = mock
    game3 = mock
    game1.stubs(:away_goals).returns(3)
    game2.stubs(:away_goals).returns(4)
    game3.stubs(:away_goals).returns(5)
    game1.stubs(:home_goals).returns(5)
    game2.stubs(:home_goals).returns(6)
    game3.stubs(:home_goals).returns(7)
    game_array = [game1, game2, game3]
    Game.stubs(:all).returns(game_array)
    assert_equal 10, Game.average_goals_per_game
  end

  def test_total_goals
    assert_equal 5, Game.all[0].total_goals
  end

  def test_hash_of_hashes
    game1 = mock
    game2 = mock
    game3 = mock
    game4 = mock
    game1.stubs(:total_goals).returns(2)
    game2.stubs(:total_goals).returns(4)
    game3.stubs(:total_goals).returns(1)
    game4.stubs(:total_goals).returns(3)
    game1.stubs(:season).returns("20122013")
    game2.stubs(:season).returns("20122013")
    game3.stubs(:season).returns("20162017")
    game4.stubs(:season).returns("20162017")
    games_array = [game1, game2, game2, game3, game4, game4, game4]
    Game.stubs(:all).returns(games_array)
    expected = {
                "20122013" => {:goals => 10, :games_played => 3},
                "20162017" => {:goals => 10, :games_played => 4}
                }
    assert_equal expected, Game.games_goals_by_season
    assert_equal expected, Game.hash_of_hashes(Game.all, :season, :goals, :games_played, :total_goals, 1)
  end

#deliverable
  def test_average_goals_by_season_and_divide_hash_values
    stub_games_goals = {
                        20122013 => {:goals => 10, :games_played => 3},
                        20162017 => {:goals => 10, :games_played => 4}
                        }
    Game.stubs(:games_goals_by_season).returns(stub_games_goals)
    expected = {"20122013" => 3.33, "20162017" => 2.5}
    assert_equal expected, Game.average_goals_by_season
    actual = Game.divide_hash_values(:goals, :games_played, Game.games_goals_by_season)
    actual = Game.keys_to_string(actual)
    assert_equal expected, actual
  end

  def test_it_can_count_games_by_season
    assert_equal ({"20122013"=>2, "20162017"=>5, "20142015"=>6, "20132014"=>4, "20152016"=>2, "20172018"=>1}), Game.count_of_games_by_season
  end

  def test_it_returns_games_goals_by_hoa_team_id
    game1 = mock
    game2 = mock
    game3 = mock
    game4 = mock
    game1.stubs(:away_team_id).returns("1")
    game2.stubs(:away_team_id).returns("1")
    game3.stubs(:away_team_id).returns("2")
    game4.stubs(:away_team_id).returns("3")
    game1.stubs(:home_team_id).returns("11")
    game2.stubs(:home_team_id).returns("11")
    game3.stubs(:home_team_id).returns("12")
    game4.stubs(:home_team_id).returns("13")
    game1.stubs(:away_goals).returns(1)
    game2.stubs(:away_goals).returns(10)
    game3.stubs(:away_goals).returns(2)
    game4.stubs(:away_goals).returns(3)
    game1.stubs(:home_goals).returns(5)
    game2.stubs(:home_goals).returns(10)
    game3.stubs(:home_goals).returns(7)
    game4.stubs(:home_goals).returns(8)
    game_array = [game1,game2,game3,game4]
    away_hash_hash = Game.hash_of_hashes(game_array, :away_team_id, :goals, :games_played, :away_goals, 1)
    home_hash_hash = Game.hash_of_hashes(game_array, :home_team_id, :goals, :games_played, :home_goals, 1)
    Game.stubs(:hash_of_hashes).returns(away_hash_hash)
    expected = {"1" => {:goals => 11, :games_played =>2},
                "2" => {:goals => 2, :games_played =>1},
                "3" => {:goals => 3, :games_played =>1}}
    assert_equal expected, Game.games_goals_by(:away_team)
    Game.stubs(:hash_of_hashes).returns(home_hash_hash)
    expected = {"11" => {:goals => 15, :games_played =>2},
                "12" => {:goals => 7, :games_played =>1},
                "13" => {:goals => 8, :games_played =>1}}
    assert_equal expected, Game.games_goals_by(:home_team)
  end

  def test_highest_scoring_visitor_team_id
    assert_equal "16", Game.highest_scoring_visitor_team_id
    games_goals = {"1" => {:goals => 11, :games_played =>2},
                   "2" => {:goals => 2, :games_played =>1},
                   "3" => {:goals => 3, :games_played =>1}}
    stub_expected = Game.divide_hash_values(:goals, :games_played, games_goals)
    Game.stubs(:average_goals_by).returns(stub_expected)
    assert_equal "1", Game.highest_scoring_visitor_team_id
  end

  def test_highest_scoring_heam_team_id
    assert_equal "6", Game.highest_scoring_home_team_id
    games_goals = {"1" => {:goals => 1, :games_played =>2},
                   "2" => {:goals => 12, :games_played =>1},
                   "3" => {:goals => 3, :games_played =>1}}
    stub_expected = Game.divide_hash_values(:goals, :games_played, games_goals)
    Game.stubs(:average_goals_by).returns(stub_expected)
    assert_equal "2", Game.highest_scoring_home_team_id
  end

  def test_lowest_scoring_visitor_team_id
    assert_equal "9", Game.lowest_scoring_visitor_team_id
    games_goals = {"1" => {:goals => 4, :games_played =>2},
                   "2" => {:goals => 12, :games_played =>10},
                   "3" => {:goals => 3, :games_played =>1}}
    stub_expected = Game.divide_hash_values(:goals, :games_played, games_goals)
    Game.stubs(:average_goals_by).returns(stub_expected)
    assert_equal "2", Game.lowest_scoring_visitor_team_id
  end

  def test_lowest_scoring_home_team_id
    assert_equal "5", Game.lowest_scoring_home_team_id
    games_goals = {"1" => {:goals => 5, :games_played =>2},
                   "2" => {:goals => 12, :games_played =>1},
                   "3" => {:goals => 4, :games_played =>3}}
    stub_expected = Game.divide_hash_values(:goals, :games_played, games_goals)
    Game.stubs(:average_goals_by).returns(stub_expected)
    assert_equal "3", Game.lowest_scoring_home_team_id
  end

  def test_it_identifies_wins_given_team_id_game_id
    assert_equal 1, Game.all[0].win?("6")
    assert_equal 1, Game.all[2].win?("24")
    assert_equal 0, Game.all[4].win?("14")
    assert_equal 0, Game.all[17].win?("4")#tie
  end

  def test_find_by_returns_array
    assert_kind_of Array, Game.find_by("2012030221")
  end

  def test_grouped_season_returns_array_of_games_grouped_by_season
    results = Game.grouped_by_season("20162017")
    assert_kind_of Array, results
    assert_kind_of Game, results.first
    assert_equal 5, results.count
    assert_equal 20, Game.all.count
  end

  def test_it_returns_wins_and_games_by_season
    expected = ({"20122013" => {:wins => 0, :games_played => 2},
                   "20142015" => {:wins => 4, :games_played => 4}})
    assert_equal expected, Game.games_and_wins_by_season("3")
    expected = ({"20122013" => {:wins => 2, :games_played => 2}})
    assert_equal expected, Game.games_and_wins_by_season("6")
  end

  def test_it_returns_percentage_of_wins_by_season_for_team_id
      assert_equal ({"20122013" => 0, "20142015" => 100}), Game.win_percent_by_season("3")
      assert_equal ({"20122013" => 100}), Game.win_percent_by_season("6")

      stub_expected = {"20122013" => {:wins => 5, :games_played => 10},
                      "20132014" => {:wins => 6, :games_played => 9},
                      "20142015" => {:wins => 4, :games_played => 16}}
      Game.stubs(:games_and_wins_by_season).returns(stub_expected)
      expected = {"20122013" => 50,
                  "20132014" => 67,
                  "20142015" => 25}
      assert_equal expected, Game.win_percent_by_season("3")
  end

  def test_it_returns_best_season_given_team_id
    assert_equal "20142015", Game.best_season("3")
    assert_equal "20122013", Game.best_season("6")
    assert_equal "20162017", Game.best_season("20")
    stub_val = {
                20122013 => 25,
                20132014 => 66,
                20142015 => 44,
                20152016 => 35,
                }
    Game.stubs(:win_percent_by_season).returns(stub_val)
    assert_equal "20132014", Game.best_season("3")
  end

  def test_it_returns_worst_season_given_team_id
    assert_equal "20122013", Game.worst_season("3")
    assert_equal "20122013", Game.worst_season("6")
    assert_equal "20162017", Game.worst_season("20")
    stub_val = {
                20122013 => 25,
                20132014 => 66,
                20142015 => 44,
                20152016 => 35,
                }
    Game.stubs(:win_percent_by_season).returns(stub_val)
    assert_equal "20122013", Game.worst_season("3")
  end

  def test_it_returns_average_win_percentage
    assert_equal 0.67, Game.average_win_percentage("3")
  end

  def test_it_returns_wins_games_by_team_id
    Game.average_win_percentage("3")
  end

end
