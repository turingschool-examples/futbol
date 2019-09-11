require './test/test_helper'
require './lib/stat_tracker'
require './lib/goalable'
require './lib/goalable_helper'

class GoalableHelperTest < Minitest::Test

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

  def test_total_goals_helper
    expected_1 = {"3"=>1129, "6"=>1154, "5"=>1262, "17"=>1007, "16"=>1156, "9"=>1038, "8"=>1019, "30"=>1062, "26"=>1065, "19"=>1068, "24"=>1146, "2"=>1053, "15"=>1168, "20"=>978, "14"=>1159, "28"=>1128, "4"=>972, "21"=>973, "25"=>1061, "13"=>955, "18"=>1101, "10"=>1007, "29"=>1029, "52"=>1041, "54"=>239, "1"=>896, "23"=>923, "12"=>936, "27"=>263, "7"=>841, "22"=>964, "53"=>620}
    expected_2 = {"7"=>841}
    assert_equal expected_1, @stat_tracker.total_goals_helper
    assert_equal expected_2, @stat_tracker.total_goals_helper("7")
  end

  def test_total_goals_allowed_helper
    expected_1 = {"3"=>1099,
                 "6"=>997,
                 "5"=>1117,
                 "17"=>1015,
                 "16"=>1095,
                 "9"=>1072,
                 "8"=>1015,
                 "30"=>1009,
                 "26"=>969,
                 "19"=>1002,
                 "24"=>1070,
                 "2"=>1096,
                 "15"=>1059,
                 "20"=>1050,
                 "14"=>1084,
                 "28"=>1030,
                 "4"=>1037,
                 "21"=>1053,
                 "25"=>1075,
                 "13"=>1028,
                 "18"=>1047,
                 "10"=>1071,
                 "29"=>1006,
                 "52"=>1003,
                 "54"=>216,
                 "1"=>973,
                 "23"=>995,
                 "12"=>996,
                 "27"=>267,
                 "7"=>1035,
                 "22"=>1062,
                 "53"=>770}
    expected_2 = {"7"=>1035}

    assert_equal expected_1, @stat_tracker.total_goals_allowed_helper
    assert_equal expected_2, @stat_tracker.total_goals_allowed_helper("7")
  end

  def test_total_goals_at_home_helper
    expected_1 = {"6"=>586,
                 "3"=>557,
                 "5"=>664,
                 "16"=>598,
                 "17"=>503,
                 "8"=>519,
                 "9"=>540,
                 "30"=>556,
                 "19"=>549,
                 "26"=>546,
                 "24"=>593,
                 "2"=>546,
                 "15"=>586,
                 "20"=>520,
                 "14"=>609,
                 "28"=>579,
                 "4"=>502,
                 "21"=>523,
                 "25"=>556,
                 "13"=>502,
                 "18"=>574,
                 "10"=>538,
                 "29"=>524,
                 "52"=>553,
                 "54"=>132,
                 "1"=>456,
                 "23"=>470,
                 "27"=>143,
                 "7"=>411,
                 "22"=>485,
                 "12"=>474,
                 "53"=>317}
    expected_2 = {"7"=>411}

    assert_equal expected_1, @stat_tracker.total_goals_at_home_helper
    assert_equal expected_2, @stat_tracker.total_goals_at_home_helper("7")
  end

  def test_total_goals_visitor_helper
    expected_1 = {"3"=>572,
                 "6"=>568,
                 "5"=>598,
                 "17"=>504,
                 "16"=>558,
                 "9"=>498,
                 "8"=>500,
                 "30"=>506,
                 "26"=>519,
                 "19"=>519,
                 "24"=>553,
                 "2"=>507,
                 "15"=>582,
                 "20"=>458,
                 "14"=>550,
                 "28"=>549,
                 "4"=>470,
                 "21"=>450,
                 "25"=>505,
                 "13"=>453,
                 "18"=>527,
                 "10"=>469,
                 "29"=>505,
                 "52"=>488,
                 "54"=>107,
                 "1"=>440,
                 "12"=>462,
                 "23"=>453,
                 "22"=>479,
                 "7"=>430,
                 "27"=>120,
                 "53"=>303}
    expected_2 = {"7"=>430}

    assert_equal expected_1, @stat_tracker.total_goals_visitor_helper
    assert_equal expected_2, @stat_tracker.total_goals_visitor_helper("7")
  end
end
