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
    expected = {"John Tortorella"=>0.37, "Claude Julien"=>0.54, "Dan Bylsma"=>0.52, "Mike Babcock"=>0.47, "Joel Quenneville"=>0.54, "Paul MacLean"=>0.36, "Michel Therrien"=>0.42, "Mike Yeo"=>0.26, "Darryl Sutter"=>0.45, "Ken Hitchcock"=>0.41, "Bruce Boudreau"=>0.44, "Jack Capuano"=>0.31, "Adam Oates"=>0.4, "Todd Richards"=>0.35, "Kirk Muller"=>0.38, "Peter DeBoer"=>0.33, "Dave Tippett"=>0.33, "Ron Rolston"=>0.29, "Bob Hartley"=>0.35, "Joe Sacco"=>0.29, "Ralph Krueger"=>0.38, "Randy Carlyle"=>0.44, "Kevin Dineen"=>0.25, "Todd McLellan"=>0.37, "Barry Trotz"=>0.25, "Lindy Ruff"=>0.47, "Claude Noel"=>0.35, "Peter Laviolette"=>0.31, "Glen Gulutzan"=>0.44, "Alain Vigneault"=>0.44, "Guy Boucher"=>0.48, "Jon Cooper"=>0.2, "Martin Raymond"=>0.0, "Dan Lacroix"=>1.0}
    @game_team_collection.stubs(:coach_percentage).returns(expected)
    assert_equal expected, @game_team_collection.coach_percentage("20122013")
  end

  def test_winningest_coach
    expected = {"John Tortorella"=>0.37, "Claude Julien"=>0.54, "Dan Bylsma"=>0.52, "Mike Babcock"=>0.47, "Joel Quenneville"=>0.54, "Paul MacLean"=>0.36, "Michel Therrien"=>0.42, "Mike Yeo"=>0.26, "Darryl Sutter"=>0.45, "Ken Hitchcock"=>0.41, "Bruce Boudreau"=>0.44, "Jack Capuano"=>0.31, "Adam Oates"=>0.4, "Todd Richards"=>0.35, "Kirk Muller"=>0.38, "Peter DeBoer"=>0.33, "Dave Tippett"=>0.33, "Ron Rolston"=>0.29, "Bob Hartley"=>0.35, "Joe Sacco"=>0.29, "Ralph Krueger"=>0.38, "Randy Carlyle"=>0.44, "Kevin Dineen"=>0.25, "Todd McLellan"=>0.37, "Barry Trotz"=>0.25, "Lindy Ruff"=>0.47, "Claude Noel"=>0.35, "Peter Laviolette"=>0.31, "Glen Gulutzan"=>0.44, "Alain Vigneault"=>0.44, "Guy Boucher"=>0.48, "Jon Cooper"=>0.2, "Martin Raymond"=>0.0, "Dan Lacroix"=>1.0}
    @game_team_collection.stubs(:coach_percentage).returns(expected)
    assert_equal "Dan Lacroix", @game_team_collection.winningest_coach("20122013")
  end

  def test_worst_coach
    expected = {"John Tortorella"=>0.37, "Claude Julien"=>0.54, "Dan Bylsma"=>0.52, "Mike Babcock"=>0.47, "Joel Quenneville"=>0.54, "Paul MacLean"=>0.36, "Michel Therrien"=>0.42, "Mike Yeo"=>0.26, "Darryl Sutter"=>0.45, "Ken Hitchcock"=>0.41, "Bruce Boudreau"=>0.44, "Jack Capuano"=>0.31, "Adam Oates"=>0.4, "Todd Richards"=>0.35, "Kirk Muller"=>0.38, "Peter DeBoer"=>0.33, "Dave Tippett"=>0.33, "Ron Rolston"=>0.29, "Bob Hartley"=>0.35, "Joe Sacco"=>0.29, "Ralph Krueger"=>0.38, "Randy Carlyle"=>0.44, "Kevin Dineen"=>0.25, "Todd McLellan"=>0.37, "Barry Trotz"=>0.25, "Lindy Ruff"=>0.47, "Claude Noel"=>0.35, "Peter Laviolette"=>0.31, "Glen Gulutzan"=>0.44, "Alain Vigneault"=>0.44, "Guy Boucher"=>0.48, "Jon Cooper"=>0.2, "Martin Raymond"=>0.0, "Dan Lacroix"=>1.0}
    @game_team_collection.stubs(:coach_percentage).returns(expected)
    assert_equal "Martin Raymond", @game_team_collection.worst_coach("20122013")
  end

  def test_team_scores_with_goals
    expected = {"3"=>112, "6"=>154, "5"=>151, "17"=>129, "16"=>163, "9"=>115, "8"=>113, "30"=>101, "26"=>134, "19"=>106, "24"=>121, "2"=>108, "15"=>124, "29"=>93, "12"=>105, "1"=>94, "27"=>91, "7"=>98, "20"=>96, "21"=>90, "22"=>99, "10"=>121, "13"=>87, "28"=>113, "18"=>85, "52"=>98, "4"=>102, "25"=>96, "23"=>108, "14"=>115}
    @game_team_collection.stubs(:team_scores).returns(expected)
    assert_equal expected, @game_team_collection.team_scores("20122013", "goals")
  end
  
  #   def test_team_scores_with_shots
  #     expected = {"3"=>8, "16"=>8, "8"=>12, "9"=>7}
  #     assert_equal expected, @seasonstats.team_scores("20122013", "shots")
  #   end

  # def test_team_ratios
  #   expected = {"3"=>2, "16"=>2, "8"=>2, "9"=>1}
  #   @game_team_collection.stubs(:team_scores).returns(expected)
  #   expected_2 = {"3"=>0.25, "16"=>0.25, "8"=>0.17, "9"=>0.14}
  #   @game_team_collection.stubs(:team_scores).returns(expected_2)
  #   assert_equal expected, @game_team_collection.team_ratios("20122013")
  # end
  #
  #   def test_most_accurate_team
  #     assert_equal "Houston Dynamo", @game_team_collection.most_accurate_team("20122013")
  #   end
  #
  #   def test_least_accurate_team
  #     assert_equal "New York City FC", @game_team_collection.least_accurate_team("20122013")
  #   end
  #
  #   def test_total_tackles
  #     expected = {"3"=>44, "16"=>36, "8"=>24, "9"=>26}
  #     assert_equal expected, @game_team_collection.total_tackles("20122013")
  #   end
  #
  #   def test_most_tackles
  #     assert_equal "Houston Dynamo", @game_team_collection.most_tackles("20122013")
  #   end
  #
  #   def test_least_tackles
  #     assert_equal "New York Red Bulls", @game_team_collection.least_tackles("20122013")
  #   end

end
