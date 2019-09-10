require './test_helper'
require 'minitest/pride'
require_relative '../lib/stat_tracker'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require_relative '../module/seasonal_sumary_stat'
require 'mocha/minitest'
require 'pry'

class SeasonSumTest < Minitest::Test

  def setup
    game_path = './test/test_data/games_sample_2.csv'
    team_path = './test/test_data/teams_sample.csv'
    game_teams_path = './test/test_data/game_teams_sample_2.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_seasonal
    expected = {
                "20122013"=>{
                  :postseason=>{
                  :win_percentage=>0.5,
                  :total_goals_scored=>5,
                  :total_goals_against=>4,
                  :average_goals_scored=>2.5,
                  :average_goals_against=>2.0},
                  :regular_season=>{
                  :win_percentage=>0.0,
                  :total_goals_scored=>2,
                  :total_goals_against=>2,
                  :average_goals_scored=>2.0,
                  :average_goals_against=>2.0}},
                "20162017"=>{
                  :postseason=>{
                  :win_percentage=>1.0,
                  :total_goals_scored=>12,
                  :total_goals_against=>7,
                  :average_goals_scored=>3.0,
                  :average_goals_against=>1.75},
                  :regular_season=>{
                  :win_percentage=>0.0,
                  :total_goals_scored=>0,
                  :total_goals_against=>0,
                  :average_goals_scored=>0,
                  :average_goals_against=>0.0}}
    }
    assert_equal expected, @stat_tracker.seasonal_summary("24")
  end

  def test_seasonal_summary_helper
    assert_instance_of Array, @stat_tracker.seasonal_summary_helper("2").values[0].values[0]
    assert_instance_of GameTeam, @stat_tracker.seasonal_summary_helper("2").values[0].values[0][0]
  end

  def test_opponent_summary
    gt_1 = mock("gt_1")
    gt_2 = mock("gt_2")
    gt_1.expects(:game_id).returns("2012030161")
    gt_2.expects(:game_id).returns("2012030162")
    arr = [gt_1, gt_2]
    assert_instance_of Array, @stat_tracker.opponent_summary("24", arr)
  end
end
