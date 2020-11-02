require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'mocha/minitest'

class StatTrackerTest < Minitest::Test

  def setup
  game_path       = './data/games_dummy.csv'
  team_path       = './data/teams.csv'
  game_teams_path = './data/game_teams_dummy.csv'

  locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists_and_can_access_data
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_game_ids_per_season
     # expected = {"20122013"=> ["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314", "2012030231", "2012030232", "2012030233", "2012030234", "2012030235", "2012030236", "2012030237", "2012030121", "2012030122", "2012030123", "2012030124", "2012030125", "2012030151", "2012030152", "2012030153", "2012030154", "2012030155", "2012030181", "2012030182", "2012030183", "2012030184", "2012030185", "2012030186", "2012030161", "2012030162", "2012030163", "2012030164", "2012030165", "2012030166", "2012030167", "2012030111", "2012030112", "2012030113", "2012030114", "2012030115", "2012030116", "2012030131", "2012030132", "2012030133", "2012030134", "2012030135", "2012030136", "2012030137", "2012030321", "2012030322"], "20162017"=>["2016030165"], "20152016"=>["2015030311"]}
     assert_equal 6, @stat_tracker.game_ids_per_season.count
  end

  def test_find_team
    assert_equal "Houston Dynamo", @stat_tracker.find_team_name("3")
  end

  # Game Stats
  def test_compare_hoa_to_result
    assert_equal 3237.0, @game_team_collection.compare_hoa_to_result("home", "WIN")
  end

  def test_it_calls_highest_total_score
    assert_equal 11, @game_collection.highest_total_score
  end

  def test_it_calls_lowest_total_score
    assert_equal 0, @game_collection.lowest_total_score
  end

  def test_it_calls_percentage_of_games_w_home_team_win
    assert_equal 43.5, @game_team_collection.percentage_home_wins
  end

  def test_it_calls_percentage_of_games_w_visitor_team_win
    assert_equal 36.11, @game_team_collection.percentage_visitor_wins
  end

  def test_it_calls_percentage_of_games_tied
    assert_equal 20.39, @game_team_collection.percentage_ties
  end

  def test_count_of_games_by_season
    assert_equal expected, @game_collection.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.22, @game_collection.average_goals_per_game
  end

  def test_average_goals_by_season
    assert_equal expected, @game_collection.average_goals_by_season
  end

  # Season Stats

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

  def test_most_accurate_team
    expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    @game_team_collection.stubs(:team_ratios).returns(expected_3)
    assert_equal "DC United", @game_team_collection.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    @game_team_collection.stubs(:team_ratios).returns(expected_3)
    assert_equal "Houston Dynamo", @game_team_collection.least_accurate_team("20122013")
  end

  def test_most_tackles
    assert_equal "FC Cincinnati", @game_team_collection.most_tackles("20122013")
  end

  def test_least_tackles
    assert_equal "Atlanta United", @game_team_collection.least_tackles("20122013")
  end

  # League Statistics Methods
  def test_it_can_count_number_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @stat_tracker.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @stat_tracker.worst_offense
  end

  def test_it_knows_highest_scoring_away
    @stat_tracker.stubs(:highest_scoring_visitor).returns('FC Dallas')
    assert_equal 'FC Dallas', @stat_tracker.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
    @stat_tracker.stubs(:highest_scoring_home_team).returns('Reign FC')
    assert_equal 'Reign FC', @stat_tracker.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
    @stat_tracker.stubs(:lowest_scoring_visitor).returns('San Jose Earthquakes')
    assert_equal 'San Jose Earthquakes', @stat_tracker.lowest_scoring_visitor
  end

  def test_it_knows_lowest_average_home
    @stat_tracker.stubs(:lowest_scoring_home_team).returns('Utah Royals FC')
    assert_equal 'Utah Royals FC', @stat_tracker.lowest_scoring_home_team
  end
  # League Statistics Helper Methods
  def test_it_can_find_team_name
    assert_equal 'Columbus Crew SC', @stat_tracker.find_team_name('53')
  end

  def test_it_knows_total_games_per_team_id_away
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_games_per_team_id_away).returns(4)
    assert_equal 4, @stat_tracker.total_games_per_team_id_away
  end

  def test_it_knows_total_games_per_team_id_home
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_games_per_team_id_home).returns(11)
    assert_equal 11, @stat_tracker.total_games_per_team_id_home
  end

  def test_it_knows_total_goals_per_team_id_away
    # expected = {"3"=>5.0, "6"=>11.0, "5"=>1.0, "20"=>4.0, "24"=>6.0}
    @stat_tracker.stubs(:total_goals_per_team_id_away).returns(5)
    assert_equal 5, @stat_tracker.total_goals_per_team_id_away
  end

  def test_it_knows_total_goals_per_team_id_home
    # expected = {"6"=>12.0, "3"=>3.0, "5"=>1.0, "24"=>6.0, "20"=>3.0}
    @stat_tracker.stubs(:total_goals_per_team_id_home).returns(12)
    assert_equal 12, @stat_tracker.total_goals_per_team_id_home
  end

# Team Stats
  def test_it_can_list_team_info
    expected = {
                team_id: '20',
                franchise_id: '21',
                team_name: 'Toronto FC',
                abbreviation: 'TOR',
                link: '/api/v1/teams/20'
              }
    assert_equal expected, @stat_tracker.team_info('20')
  end

  def test_it_can_find_best_season
  # Season with the highest win percentage for a team.
    assert_equal '20122013', @stat_tracker.best_season('3')
  end

  def test_it_can_find_worst_season
  # Season with the lowest win percentage for a team.
    assert_equal "20122013", @stat_tracker.worst_season('3')
  end

  def test_it_can_find_average_win_percentage
  # Average win percentage of all games for a team.
    assert_equal 53.0, @stat_tracker.average_win_percentage('3')
  end

  def test_it_can_find_highest_goals_by_team
    # Highest number of goals a particular team has scored in a single game.
    assert_equal 2, @stat_tracker.most_goals_scored('3')
  end

  def test_it_can_find_fewest_goals_by_team
    # Lowest numer of goals a particular team has scored in a single game.
    assert_equal 0, @stat_tracker.fewest_goals_scored('3')
  end

  def test_it_can_find_favorite_oponent
  # Name of the opponent that has the lowest win percentage against the given team.
    assert_equal 'Portland Timbers', @stat_tracker.favorite_oponent('3')
  end

  def test_it_can_find_rival
  # Name of the opponent that has the highest win percentage against the given team
    assert_equal 'Portland Timbers', @stat_tracker.rival('3')
  end
end
