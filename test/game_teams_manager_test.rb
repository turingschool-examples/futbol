require './test/test_helper'
require './lib/game_teams'
require './lib/game_teams_manager'
require 'mocha/minitest'

class GameTeamsManagerTest < Minitest::Test
  def setup
    @game_teams_manager = GameTeamsManager.new('./data/game_teams.csv')
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamsManager, @game_teams_manager
  end

  def test_it_can_add_array_of_all_game_team_objects
    assert_instance_of GameTeam, @game_teams_manager.game_teams.first
  end

  def test_total_goals_by_team
    expected = {:game_count=>516, :goals=>1128}
    assert_equal expected, @game_teams_manager.total_goals_by_team["28"]
    expected = {:game_count=>258, :goals=>549}
    assert_equal expected, @game_teams_manager.total_goals_by_team('away')["28"]
    expected = {:game_count=>258, :goals=>579}
    assert_equal expected, @game_teams_manager.total_goals_by_team('home')["28"]
  end

  def test_avg_goals_by_team
    assert_equal 2.3431, @game_teams_manager.avg_goals_by_team["54"]
    assert_equal 2.5882, @game_teams_manager.avg_goals_by_team('home')["54"]
    assert_equal 2.098, @game_teams_manager.avg_goals_by_team('away')["54"]
  end

  def test_best_offense
    @game_teams_manager.expects(:avg_goals_by_team).returns({"3"=>2.13,
    "6"=>2.26,
    "5"=>2.29,
    "17"=>2.06,
    "16"=>2.16,
    "9"=>2.11,
    "8"=>2.05,
    "30"=>2.12,
    "26"=>2.08,
    "19"=>2.11,
    "24"=>2.2,
    "2"=>2.18,
    "15"=>2.21,
    "20"=>2.07,
    "14"=>2.22,
    "28"=>2.19,
    "4"=>2.04,
    "21"=>2.07,
    "25"=>2.22,
    "13"=>2.06,
    "18"=>2.15,
    "10"=>2.11,
    "29"=>2.17,
    "52"=>2.17,
    "54"=>2.34,
    "1"=>1.94,
    "23"=>1.97,
    "12"=>2.04,
    "27"=>2.02,
    "7"=>1.84,
    "22"=>2.05,
    "53"=>1.89})
    assert_equal "54", @game_teams_manager.best_offense
  end

  def test_worst_offense
    @game_teams_manager.expects(:avg_goals_by_team).returns({"3"=>2.13,
    "6"=>2.26,
    "5"=>2.29,
    "17"=>2.06,
    "16"=>2.16,
    "9"=>2.11,
    "8"=>2.05,
    "30"=>2.12,
    "26"=>2.08,
    "19"=>2.11,
    "24"=>2.2,
    "2"=>2.18,
    "15"=>2.21,
    "20"=>2.07,
    "14"=>2.22,
    "28"=>2.19,
    "4"=>2.04,
    "21"=>2.07,
    "25"=>2.22,
    "13"=>2.06,
    "18"=>2.15,
    "10"=>2.11,
    "29"=>2.17,
    "52"=>2.17,
    "54"=>2.34,
    "1"=>1.94,
    "23"=>1.97,
    "12"=>2.04,
    "27"=>2.02,
    "7"=>1.84,
    "22"=>2.05,
    "53"=>1.89})
    assert_equal "7", @game_teams_manager.worst_offense
  end

  def test_highest_scoring_visitor
    @game_teams_manager.expects(:avg_goals_by_team).returns({"3"=>2.15,
    "6"=>2.25,
    "5"=>2.18,
    "17"=>2.04,
    "16"=>2.1,
    "9"=>2.01,
    "8"=>2.01,
    "30"=>2.01,
    "26"=>2.03,
    "19"=>2.04,
    "24"=>2.14,
    "2"=>2.1,
    "15"=>2.2,
    "20"=>1.93,
    "14"=>2.12,
    "28"=>2.13,
    "4"=>1.97,
    "21"=>1.91,
    "25"=>2.12,
    "13"=>1.95,
    "18"=>2.05,
    "10"=>1.95,
    "29"=>2.12,
    "52"=>2.04,
    "54"=>2.1,
    "1"=>1.9,
    "12"=>2.02,
    "23"=>1.94,
    "22"=>2.03,
    "7"=>1.88,
    "27"=>1.85,
    "53"=>1.85})
    assert_equal "6", @game_teams_manager.highest_scoring_visitor
  end

  def test_highest_scoring_home_team
    @game_teams_manager.expects(:avg_goals_by_team).returns({"6"=>2.28,
    "3"=>2.1,
    "5"=>2.39,
    "16"=>2.23,
    "17"=>2.08,
    "8"=>2.08,
    "9"=>2.2,
    "30"=>2.22,
    "19"=>2.17,
    "26"=>2.14,
    "24"=>2.25,
    "2"=>2.28,
    "15"=>2.22,
    "20"=>2.2,
    "14"=>2.32,
    "28"=>2.24,
    "4"=>2.11,
    "21"=>2.22,
    "25"=>2.33,
    "13"=>2.16,
    "18"=>2.24,
    "10"=>2.26,
    "29"=>2.21,
    "52"=>2.3,
    "54"=>2.59,
    "1"=>1.97,
    "23"=>2.01,
    "27"=>2.2,
    "7"=>1.79,
    "22"=>2.06,
    "12"=>2.07,
    "53"=>1.93})
    assert_equal "54", @game_teams_manager.highest_scoring_home_team
  end

  def test_lowest_scoring_visitor
    @game_teams_manager.expects(:avg_goals_by_team).returns({"3"=>2.15,
    "6"=>2.25,
    "5"=>2.18,
    "17"=>2.04,
    "16"=>2.1,
    "9"=>2.01,
    "8"=>2.01,
    "30"=>2.01,
    "26"=>2.03,
    "19"=>2.04,
    "24"=>2.14,
    "2"=>2.1,
    "15"=>2.2,
    "20"=>1.93,
    "14"=>2.12,
    "28"=>2.13,
    "4"=>1.97,
    "21"=>1.91,
    "25"=>2.12,
    "13"=>1.95,
    "18"=>2.05,
    "10"=>1.95,
    "29"=>2.12,
    "52"=>2.04,
    "54"=>2.1,
    "1"=>1.9,
    "12"=>2.02,
    "23"=>1.94,
    "22"=>2.03,
    "7"=>1.88,
    "27"=>1.85,
    "53"=>1.85})
    assert_equal "27", @game_teams_manager.lowest_scoring_visitor
  end

  def test_lowest_scoring_home_team
    @game_teams_manager.expects(:avg_goals_by_team).returns({"6"=>2.28,
    "3"=>2.1,
    "5"=>2.39,
    "16"=>2.23,
    "17"=>2.08,
    "8"=>2.08,
    "9"=>2.2,
    "30"=>2.22,
    "19"=>2.17,
    "26"=>2.14,
    "24"=>2.25,
    "2"=>2.28,
    "15"=>2.22,
    "20"=>2.2,
    "14"=>2.32,
    "28"=>2.24,
    "4"=>2.11,
    "21"=>2.22,
    "25"=>2.33,
    "13"=>2.16,
    "18"=>2.24,
    "10"=>2.26,
    "29"=>2.21,
    "52"=>2.3,
    "54"=>2.59,
    "1"=>1.97,
    "23"=>2.01,
    "27"=>2.2,
    "7"=>1.79,
    "22"=>2.06,
    "12"=>2.07,
    "53"=>1.93})
    assert_equal "7", @game_teams_manager.lowest_scoring_home_team
  end

  def test_it_gives_games_by_season
    assert_equal 4, @game_teams_manager.games_by_season([2012030222, 2012030223]).size
  end

  def test_it_gives_coach_stats
    expected = {"John Tortorella"=>{:game_count=>2, :num_wins=>0}, "Claude Julien"=>{:game_count=>2, :num_wins=>2}}
    assert_equal expected, @game_teams_manager.coach_stats([2012030222, 2012030223])
  end

  def test_winningest_coach
    @game_teams_manager.expects(:coach_stats).returns({"John Tortorella"=>{:game_count=>2, :num_wins=>0}, "Claude Julien"=>{:game_count=>2, :num_wins=>2}})

    assert_equal "Claude Julien", @game_teams_manager.winningest_coach([2012030222, 2012030223])
  end

  def test_worst_coach
    @game_teams_manager.expects(:coach_stats).returns({"John Tortorella"=>{:game_count=>2, :num_wins=>0}, "Claude Julien"=>{:game_count=>2, :num_wins=>2}})

    assert_equal "John Tortorella", @game_teams_manager.worst_coach([2012030222, 2012030223])
  end

  def test_team_goal_ratio
    expected = {"3"=>{:goals=>3, :shots=>15}, "6"=>{:goals=>5, :shots=>16}}
    assert_equal expected, @game_teams_manager.team_goal_ratio([2012030222, 2012030223])
  end

  def test_most_accurate_team
    @game_teams_manager.expects(:team_goal_ratio).returns({"3"=>{:goals=>3, :shots=>15}, "6"=>{:goals=>5, :shots=>16}})

    assert_equal "6", @game_teams_manager.most_accurate_team([2012030222, 2012030223])
  end

  def test_least_accurate_team
    @game_teams_manager.expects(:team_goal_ratio).returns({"3"=>{:goals=>3, :shots=>15}, "6"=>{:goals=>5, :shots=>16}})

    assert_equal "3", @game_teams_manager.least_accurate_team([2012030222, 2012030223])
  end

  def test_total_tackles_by_team
    expected = ({"3"=>70, "6"=>64})
    assert_equal expected, @game_teams_manager.total_tackles_by_team([2012030222, 2012030223])
  end

  def test_most_tackles
    @game_teams_manager.expects(:total_tackles_by_team).returns({"3"=>70, "6"=>64})

    assert_equal "3",  @game_teams_manager.most_tackles([2012030222, 2012030223])
  end

  def test_fewest_tackles
    @game_teams_manager.expects(:total_tackles_by_team).returns({"3"=>70, "6"=>64})
    
    assert_equal "6", @game_teams_manager.fewest_tackles([2012030222, 2012030223])
  end
end
