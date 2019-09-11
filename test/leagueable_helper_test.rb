require './test/test_helper'
require './lib/stat_tracker'
require './lib/leagueable'
require './lib/leagueable_helper'

class LeagueableHelperTest < Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_total_games_helper
    expected_1 = {"3"=>531, "6"=>510, "5"=>552, "17"=>489, "16"=>534, "9"=>493, "8"=>498, "30"=>502, "26"=>511, "19"=>507, "24"=>522, "2"=>482, "15"=>528, "20"=>473, "14"=>522, "28"=>516, "4"=>477, "21"=>471, "25"=>477, "13"=>464, "18"=>513, "10"=>478, "29"=>475, "52"=>479, "54"=>102, "1"=>463, "23"=>468, "12"=>458, "27"=>130, "7"=>458, "22"=>471, "53"=>328}
    expected_2 = {"7"=>458}

    assert_equal expected_1, @stat_tracker.total_games_helper
    assert_equal expected_2, @stat_tracker.total_games_helper("7")
  end

  def test_total_away_games_helper
    expected_1 = {"3"=>266, "6"=>253, "5"=>274, "17"=>247, "16"=>266, "9"=>248, "8"=>249, "30"=>252, "26"=>256, "19"=>254, "24"=>258, "2"=>242, "15"=>264, "20"=>237, "14"=>259, "28"=>258, "4"=>239, "21"=>235, "25"=>238, "13"=>232, "18"=>257, "10"=>240, "29"=>238, "52"=>239, "54"=>51, "1"=>232, "12"=>229, "23"=>234, "22"=>236, "7"=>229, "27"=>65, "53"=>164}
    expected_2 = {"7"=>229}

    assert_equal expected_1, @stat_tracker.total_away_games_helper
    assert_equal expected_2, @stat_tracker.total_away_games_helper("7")
  end
  #
  def test_total_home_games_helper
    expected_1 = {"3"=>266, "6"=>253, "5"=>274, "17"=>247, "16"=>266, "9"=>248, "8"=>249, "30"=>252, "26"=>256, "19"=>254, "24"=>258, "2"=>242, "15"=>264, "20"=>237, "14"=>259, "28"=>258, "4"=>239, "21"=>235, "25"=>238, "13"=>232, "18"=>257, "10"=>240, "29"=>238, "52"=>239, "54"=>51, "1"=>232, "12"=>229, "23"=>234, "22"=>236, "7"=>229, "27"=>65, "53"=>164}
    expected_2 = {"7"=>229}

    assert_equal expected_1, @stat_tracker.total_home_games_helper
    assert_equal expected_2, @stat_tracker.total_home_games_helper("7")
  end

  def test_total_away_wins_helper
    expected_1 = {"6"=>122, "17"=>86, "9"=>76, "16"=>107, "19"=>107, "26"=>100, "24"=>110, "5"=>121, "15"=>113, "3"=>119, "14"=>101, "28"=>99, "4"=>66, "30"=>86, "25"=>76, "8"=>90, "2"=>82, "13"=>75, "54"=>20, "29"=>88, "52"=>86, "18"=>97, "21"=>76, "1"=>76, "22"=>73, "7"=>65, "10"=>74, "27"=>14, "20"=>83, "23"=>78, "12"=>80, "53"=>41}
    expected_2 = {"7"=>65}
  assert_equal expected_1, @stat_tracker.total_away_wins_helper
  assert_equal expected_2, @stat_tracker.total_away_wins_helper("7")
  end

  def test_total_home_wins_helper
    expected_1 = {"6"=>129, "16"=>129, "17"=>99, "8"=>118, "9"=>96, "30"=>126, "19"=>119, "26"=>131, "24"=>127, "5"=>146, "2"=>91, "15"=>131, "3"=>111, "28"=>132, "4"=>94, "14"=>117, "21"=>97, "25"=>111, "13"=>87, "18"=>120, "29"=>102, "54"=>31, "52"=>107, "1"=>90, "10"=>87, "23"=>94, "27"=>30, "7"=>64, "22"=>84, "12"=>94, "53"=>53, "20"=>90}
    expected_2 = {"7"=>64}

  assert_equal expected_1, @stat_tracker.total_home_wins_helper
  assert_equal expected_2, @stat_tracker.total_home_wins_helper("7")
  end

  def test_total_wins_helper
    expected_1 = {"6"=>251, "16"=>236, "17"=>185, "8"=>208, "9"=>172, "30"=>212, "19"=>226, "26"=>231, "24"=>237, "5"=>267, "2"=>173, "15"=>244, "3"=>230, "14"=>218, "28"=>231, "4"=>160, "21"=>173, "25"=>187, "13"=>162, "18"=>217, "29"=>190, "54"=>51, "52"=>193, "1"=>166, "10"=>161, "23"=>172, "27"=>44, "22"=>157, "7"=>129, "20"=>173, "12"=>174, "53"=>94 }
    expected_2 = {"7"=>129}

  assert_equal expected_1, @stat_tracker.total_wins_helper
  assert_equal expected_2, @stat_tracker.total_wins_helper("7")
  end

  def test_team_name_finder_helper
  assert_equal "Utah Royals FC", @stat_tracker.team_name_finder_helper("7")
  end

  def test_unique_home_teams_array_helper
    expected_array = ["6", "3", "5", "16", "17", "8", "9", "30", "19", "26", "24", "2", "15", "20", "14", "28", "4", "21", "25", "13", "18", "10", "29", "52", "54", "1", "23", "27", "7", "22", "12", "53"]

  assert_equal expected_array, @stat_tracker.unique_home_teams_array_helper
  end

  def test_unique_away_teams_array_helper
    expected_array = ["3", "6", "5", "17", "16", "9", "8", "30", "26", "19", "24", "2", "15", "20", "14", "28", "4", "21", "25", "13", "18", "10", "29", "52", "54", "1", "12", "23", "22", "7", "27", "53"]

  assert_equal expected_array, @stat_tracker.unique_away_teams_array_helper
  end

end
