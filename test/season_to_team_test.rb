require './test_helper'
require 'minitest/pride'
require_relative '../lib/stat_tracker'
require_relative '../lib/team'
require_relative '../lib/game'
require_relative '../lib/game_team'
require_relative '../module/season_to_team_stats'
require 'mocha/minitest'
require 'pry'

class SeasonToTeamStatsTest < Minitest::Test
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

  def test_seasonal_info
    expected = {
      "20"=>{
        :postseason=>{
          :game_count=>4,
          :win_count=>0,
          :goal_count=>7,
          :shot_count=>34,
          :tackle_count=>123},
        :regular_season=>{
          :game_count=>0,
          :win_count=>0,
          :goal_count=>0,
          :shot_count=>0,
          :tackle_count=>0}},
      "24"=>{
        :postseason=>{
          :game_count=>4,
          :win_count=>4,
          :goal_count=>12,
          :shot_count=>29,
          :tackle_count=>106},
        :regular_season=>{
          :game_count=>0,
          :win_count=>0,
          :goal_count=>0,
          :shot_count=>0,
          :tackle_count=>0}
        }
    }
    assert_equal expected, @stat_tracker.seasonal_info("20162017")
  end
end
