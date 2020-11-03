require './test/test_helper'

class GameTeamSeasonTest < Minitest::Test
  def setup
    game_path       = './data/games_dummy.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path,
                }

    @stat_tracker         = StatTracker.from_csv(locations)
    @game_team_season     = GameTeamSeason.new(game_teams_path, @stat_tracker)
  end

  def test_games_in_season
    assert_equal 114, @game_team_season.games_in_season("20122013").count
  end

  def test_games_per_coach
    assert_equal 13, @game_team_season.games_per_coach("20122013").count
  end

  def test_count_coach_results
    expected = {"John Tortorella"=>2, "Claude Julien"=>9, "Dan Bylsma"=>4, "Mike Babcock"=>7, "Joel Quenneville"=>9, "Paul MacLean"=>3, "Michel Therrien"=>1, "Mike Yeo"=>1, "Darryl Sutter"=>5, "Ken Hitchcock"=>3, "Bruce Boudreau"=>4, "Jack Capuano"=>2, "Adam Oates"=>5}
    assert_equal expected, @game_team_season.count_coach_results("20122013")
  end

  def test_coach_percentage
    expected = {"John Tortorella"=>0.17, "Claude Julien"=>1.0, "Dan Bylsma"=>0.4, "Mike Babcock"=>0.5, "Joel Quenneville"=>0.53, "Paul MacLean"=>0.6, "Michel Therrien"=>0.2, "Mike Yeo"=>0.2, "Darryl Sutter"=>0.45, "Ken Hitchcock"=>0.5, "Bruce Boudreau"=>0.57, "Jack Capuano"=>0.33, "Adam Oates"=>0.71}
    assert_equal expected, @game_team_season.coach_percentage("20122013")
  end

  def test_winningest_coach
    expected = {"John Tortorella"=>0.37, "Claude Julien"=>0.54, "Dan Bylsma"=>0.52, "Mike Babcock"=>0.47, "Joel Quenneville"=>0.54, "Paul MacLean"=>0.36, "Michel Therrien"=>0.42, "Mike Yeo"=>0.26, "Darryl Sutter"=>0.45, "Ken Hitchcock"=>0.41, "Bruce Boudreau"=>0.44, "Jack Capuano"=>0.31, "Adam Oates"=>0.4, "Todd Richards"=>0.35, "Kirk Muller"=>0.38, "Peter DeBoer"=>0.33, "Dave Tippett"=>0.33, "Ron Rolston"=>0.29, "Bob Hartley"=>0.35, "Joe Sacco"=>0.29, "Ralph Krueger"=>0.38, "Randy Carlyle"=>0.44, "Kevin Dineen"=>0.25, "Todd McLellan"=>0.37, "Barry Trotz"=>0.25, "Lindy Ruff"=>0.47, "Claude Noel"=>0.35, "Peter Laviolette"=>0.31, "Glen Gulutzan"=>0.44, "Alain Vigneault"=>0.44, "Guy Boucher"=>0.48, "Jon Cooper"=>0.2, "Martin Raymond"=>0.0, "Dan Lacroix"=>1.0}
    @game_team_season.stubs(:coach_percentage).returns(expected)
    assert_equal "Dan Lacroix", @game_team_season.winningest_coach("20122013")
  end

  def test_worst_coach
    expected = {"John Tortorella"=>0.37, "Claude Julien"=>0.54, "Dan Bylsma"=>0.52, "Mike Babcock"=>0.47, "Joel Quenneville"=>0.54, "Paul MacLean"=>0.36, "Michel Therrien"=>0.42, "Mike Yeo"=>0.26, "Darryl Sutter"=>0.45, "Ken Hitchcock"=>0.41, "Bruce Boudreau"=>0.44, "Jack Capuano"=>0.31, "Adam Oates"=>0.4, "Todd Richards"=>0.35, "Kirk Muller"=>0.38, "Peter DeBoer"=>0.33, "Dave Tippett"=>0.33, "Ron Rolston"=>0.29, "Bob Hartley"=>0.35, "Joe Sacco"=>0.29, "Ralph Krueger"=>0.38, "Randy Carlyle"=>0.44, "Kevin Dineen"=>0.25, "Todd McLellan"=>0.37, "Barry Trotz"=>0.25, "Lindy Ruff"=>0.47, "Claude Noel"=>0.35, "Peter Laviolette"=>0.31, "Glen Gulutzan"=>0.44, "Alain Vigneault"=>0.44, "Guy Boucher"=>0.48, "Jon Cooper"=>0.2, "Martin Raymond"=>0.0, "Dan Lacroix"=>1.0}
    @game_team_season.stubs(:coach_percentage).returns(expected)
    assert_equal "Martin Raymond", @game_team_season.worst_coach("20122013")
  end

  def test_team_scores_with_goals
    expected = {"3"=>18, "6"=>24, "5"=>17, "17"=>27, "16"=>33, "9"=>14, "8"=>9, "30"=>7, "26"=>21, "19"=>10, "24"=>17, "2"=>11, "15"=>12}
    assert_equal expected, @game_team_season.team_scores("20122013", "goals")
  end

  def test_team_scores_with_shots
    expected = {"3"=>87, "6"=>76, "5"=>71, "17"=>98, "16"=>134, "9"=>36, "8"=>43, "30"=>33, "26"=>69, "19"=>42, "24"=>54, "2"=>47, "15"=>52}
    assert_equal expected, @game_team_season.team_scores("20122013", "shots")
  end

  def test_team_ratios
    expected = {"3"=>112, "6"=>154, "5"=>151, "17"=>129, "16"=>163, "9"=>115, "8"=>113, "30"=>101, "26"=>134, "19"=>106, "24"=>121, "2"=>108, "15"=>124, "29"=>93, "12"=>105, "1"=>94, "27"=>91, "7"=>98, "20"=>96, "21"=>90, "22"=>99, "10"=>121, "13"=>87, "28"=>113, "18"=>85, "52"=>98, "4"=>102, "25"=>96, "23"=>108, "14"=>115}
    expected_2 = {"3"=>441, "6"=>561, "5"=>459, "17"=>440, "16"=>545, "9"=>455, "8"=>396, "30"=>361, "26"=>449, "19"=>358, "24"=>373, "2"=>400, "15"=>372, "29"=>303, "12"=>368, "1"=>322, "27"=>352, "7"=>319, "20"=>303, "21"=>337, "22"=>307, "10"=>358, "13"=>333, "28"=>444, "18"=>291, "52"=>331, "4"=>331, "25"=>297, "23"=>348, "14"=>312}
    @game_team_season.stubs(:team_scores).returns(expected, expected_2)
    expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    assert_equal expected_3, @game_team_season.team_ratios("20122013")
  end

  def test_most_accurate_team
    expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    @game_team_season.stubs(:team_ratios).returns(expected_3)
    assert_equal "DC United", @game_team_season.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    @game_team_season.stubs(:team_ratios).returns(expected_3)
    assert_equal "Houston Dynamo", @game_team_season.least_accurate_team("20122013")
  end

  def test_total_tackles
    expected = {"3"=>466, "6"=>271, "5"=>329, "17"=>380, "16"=>458, "9"=>181, "8"=>173, "30"=>165, "26"=>460, "19"=>238, "24"=>215, "2"=>198, "15"=>244}
    assert_equal expected, @game_team_season.total_tackles("20122013")
  end

  def test_most_tackles
    assert_equal "Houston Dynamo", @game_team_season.most_tackles("20122013")
  end

  def test_least_tackles
    assert_equal "Orlando City SC", @game_team_season.least_tackles("20122013")
  end

end
