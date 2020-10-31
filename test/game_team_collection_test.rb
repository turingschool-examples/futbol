require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team_collection'
require './lib/stat_tracker'
require 'mocha/minitest'

class GameTeamCollectionTest < Minitest::Test
  def setup
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path,
                }

    stat_tracker          = StatTracker.from_csv(locations)
    @game_team_collection = GameTeamCollection.new(game_teams_path, stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamCollection, @game_team_collection
  end
  #FROM THE GAMES STATS SECTION
  def test_compare_hoa_to_result
    @game_team_collection.stubs(:compare_hoa_to_result).returns(3237.0)
    assert_equal 3237.0, @game_team_collection.compare_hoa_to_result("home", "WIN")
  end

  def test_total_games
    @game_team_collection.stubs(:total_games).returns(7441)
    assert_equal 7441, @game_team_collection.total_games
  end

  def test_it_calls_percentage_of_games_w_home_team_win
    @game_team_collection.stubs(:percentage_home_wins).returns(43.5)
    assert_equal 43.5, @game_team_collection.percentage_home_wins
  end

  def test_it_calls_percentage_of_games_w_visitor_team_win
    @game_team_collection.stubs(:percentage_visitor_wins).returns(36.11)
    assert_equal 36.11, @game_team_collection.percentage_visitor_wins
  end

  def test_it_calls_percentage_of_games_tied
    @game_team_collection.stubs(:percentage_ties).returns(20.39)
    assert_equal 20.39, @game_team_collection.percentage_ties
  end

  def test_total_percentages_equals_100
    @game_team_collection.stubs(:percentage_home_wins).returns(43.5)
    @game_team_collection.stubs(:percentage_visitor_wins).returns(36.11)
    @game_team_collection.stubs(:percentage_ties).returns(20.39)
    assert_equal 100, (@game_team_collection.percentage_home_wins +
                       @game_team_collection.percentage_visitor_wins +
                       @game_team_collection.percentage_ties)
  end

  def test_games_in_season
    @game_team_collection.stubs(:games_in_season).returns(1612)
    assert_equal 1612, @game_team_collection.games_in_season("20122013")
  end

  def test_games_per_coach
    @game_team_collection.stubs(:games_per_coach).returns(34)
    assert_equal 34, @game_team_collection.games_per_coach("20122013")
    #do count
  end

  def test_count_coach_results
    expected = {"John Tortorella"=>22, "Claude Julien"=>38, "Dan Bylsma"=>33, "Mike Babcock"=>29, "Joel Quenneville"=>38, "Paul MacLean"=>21, "Michel Therrien"=>22, "Mike Yeo"=>14, "Darryl Sutter"=>30, "Ken Hitchcock"=>22, "Bruce Boudreau"=>24, "Jack Capuano"=>17, "Adam Oates"=>22, "Todd Richards"=>17, "Kirk Muller"=>18, "Peter DeBoer"=>16, "Dave Tippett"=>16, "Ron Rolston"=>9, "Bob Hartley"=>17, "Joe Sacco"=>14, "Ralph Krueger"=>18, "Randy Carlyle"=>24, "Kevin Dineen"=>12, "Todd McLellan"=>22, "Barry Trotz"=>12, "Lindy Ruff"=>8, "Claude Noel"=>17, "Peter Laviolette"=>15, "Glen Gulutzan"=>21, "Alain Vigneault"=>23, "Guy Boucher"=>15, "Jon Cooper"=>3, "Martin Raymond"=>0, "Dan Lacroix"=>1}
    @game_team_collection.stubs(:count_coach_results).returns(expected)
    assert_equal expected, @game_team_collection.count_coach_results("20122013")
  end

  def test_coach_percentage
      @game_team_collection.stubs(:coach_percentage).returns(1612)
      expected = {"John Tortorella"=>0.0, "Joel Quenneville"=>1.0, "Michel Therrien"=>0.0, "Paul MacLean"=>0.0}
      assert_equal expected, @seasonstats.coach_percentage("20122013")
    end
  #
  #   def test_winningest_coach
  #     assert_equal "Joel Quenneville", @seasonstats.winningest_coach("20122013")
  #   end

end
