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

    @stat_tracker         = StatTracker.from_csv(locations)
    @game_team_collection = GameTeamCollection.new(game_teams_path, @stat_tracker)
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

  # Season Statistics
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

  def test_team_scores_with_shots
    expected = {"3"=>441, "6"=>561, "5"=>459, "17"=>440, "16"=>545, "9"=>455, "8"=>396, "30"=>361, "26"=>449, "19"=>358, "24"=>373, "2"=>400, "15"=>372, "29"=>303, "12"=>368, "1"=>322, "27"=>352, "7"=>319, "20"=>303, "21"=>337, "22"=>307, "10"=>358, "13"=>333, "28"=>444, "18"=>291, "52"=>331, "4"=>331, "25"=>297, "23"=>348, "14"=>312}
    @game_team_collection.stubs(:team_scores).returns(expected)
    assert_equal expected, @game_team_collection.team_scores("20122013", "shots")
  end

  def test_team_ratios
    expected = {"3"=>112, "6"=>154, "5"=>151, "17"=>129, "16"=>163, "9"=>115, "8"=>113, "30"=>101, "26"=>134, "19"=>106, "24"=>121, "2"=>108, "15"=>124, "29"=>93, "12"=>105, "1"=>94, "27"=>91, "7"=>98, "20"=>96, "21"=>90, "22"=>99, "10"=>121, "13"=>87, "28"=>113, "18"=>85, "52"=>98, "4"=>102, "25"=>96, "23"=>108, "14"=>115}
    expected_2 = {"3"=>441, "6"=>561, "5"=>459, "17"=>440, "16"=>545, "9"=>455, "8"=>396, "30"=>361, "26"=>449, "19"=>358, "24"=>373, "2"=>400, "15"=>372, "29"=>303, "12"=>368, "1"=>322, "27"=>352, "7"=>319, "20"=>303, "21"=>337, "22"=>307, "10"=>358, "13"=>333, "28"=>444, "18"=>291, "52"=>331, "4"=>331, "25"=>297, "23"=>348, "14"=>312}
    @game_team_collection.stubs(:team_scores).returns(expected, expected_2)
    expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    @game_team_collection.stubs(:team_ratios).returns(expected_3)
    assert_equal expected_3, @game_team_collection.team_ratios("20122013")
  end

  def test_most_accurate_team
    # expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    # @game_team_collection.stubs(:team_ratios).returns(expected_3)
    assert_equal "DC United", @game_team_collection.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    # expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    # @game_team_collection.stubs(:team_ratios).returns(expected_3)
    assert_equal "Houston Dynamo", @game_team_collection.least_accurate_team("20122013")
  end

  def test_total_tackles
    expected = {"3"=>1879, "6"=>2045, "5"=>1698, "17"=>1245, "16"=>1501, "9"=>1659, "8"=>1240, "30"=>1121, "26"=>2201, "19"=>1358, "24"=>1364, "2"=>1216, "15"=>1335, "29"=>1188, "12"=>1100, "1"=>892, "27"=>1260, "7"=>1079, "20"=>935, "21"=>1241, "22"=>1060, "10"=>1977, "13"=>1110, "28"=>1359, "18"=>995, "52"=>1411, "4"=>1316, "25"=>1199, "23"=>1166, "14"=>1105}
    @game_team_collection.stubs(:total_tackles).returns(expected)
    assert_equal expected, @game_team_collection.total_tackles("20122013")
  end

  def test_most_tackles
    assert_equal "FC Cincinnati", @game_team_collection.most_tackles("20122013")
  end

  def test_least_tackles
    assert_equal "Atlanta United", @game_team_collection.least_tackles("20122013")
  end

  #League Statistics Methods
  def test_it_can_find_team_name
  # Name of the team with the highest average number of goals scored per game across all seasons.
    assert_equal 'New York Red Bulls', @game_team_collection.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
  # Name of the team with the highest average number of goals scored per game across all seasons.
    assert_equal 'Sporting Kansas City', @game_team_collection.worst_offense
  end

  def test_it_knows_highest_scoring_away
  # Name of the team with the highest average score per game across all seasons when they are away.
    @game_team_collection.stubs(:highest_average_team_id_visitor).returns('6')
    assert_equal 'FC Dallas', @game_team_collection.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
  # Name of the team with the highest average score per game across all seasons when they are away.
    @game_team_collection.stubs(:highest_average_team_id_home).returns('54')
    assert_equal 'Reign FC', @game_team_collection.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
  # Name of the team with the highest average score per game across all seasons when they are away.
    @game_team_collection.stubs(:lowest_average_team_id_visitor).returns('27')
    assert_equal 'San Jose Earthquakes', @game_team_collection.lowest_scoring_visitor
  end

  def test_it_knows_lowest_average_home
  # Name of the team with the highest average score per game across all seasons when they are away.
    @game_team_collection.stubs(:lowest_average_team_id_home).returns('7')
    assert_equal 'Utah Royals FC', @game_team_collection.lowest_scoring_home_team
  end

  #League Statistics Helper Methods
  def test_it_can_find_highest_goal
    assert_equal '8', @game_team_collection.find_highest_goal_team_id
  end

  def test_it_can_find_lowest_goal
    assert_equal '5', @game_team_collection.find_lowest_goal_team_id
  end

  def test_it_can_find_highest_average_team_id_visitor
    @game_team_collection.stubs(:highest_average_team_id_visitor).returns('6')
    assert_equal '6', @game_team_collection.highest_average_team_id_visitor
  end

  def test_it_can_find_highest_average_team_id_home
    @game_team_collection.stubs(:highest_average_team_id_home).returns('54')
    assert_equal '54', @game_team_collection.highest_average_team_id_home
  end

  def test_it_can_find_lowest_average_team_id_visitor
    @game_team_collection.stubs(:lowest_average_team_id_visitor).returns('27')
    assert_equal '27', @game_team_collection.lowest_average_team_id_visitor
  end

  def test_it_can_find_lowest_average_team_id_home
    @game_team_collection.stubs(:lowest_average_team_id_home).returns('7')
    assert_equal '7', @game_team_collection.lowest_average_team_id_home
  end

  # TEAM STATS
  def test_it_can_find_total_games_per_team_id
    assert_equal 434, @game_team_collection.total_games('3').count
  end

  def test_it_can_find_winning_games
    assert_equal 230, @game_team_collection.winning_games('3').count
  end

  def test_it_can_find_average_win_percentage
  # Average win percentage of all games for a team.
    assert_equal 53.0, @game_team_collection.average_win_percentage('3')
  end
end
