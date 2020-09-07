require './test/test_helper'
require './lib/season_stats_module'
require './lib/stat_tracker'
require 'pry'

class SeasonStatisticsTest <Minitest::Test

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

  def test_find_all_games_from_season

    expected = {
                :away_goals => 2,
                :away_team_id=>"3",
                :date_time=>"5/16/13",
                :game_id=>"2012030221",
                :home_goals=>3,
                :home_team_id=>"6",
                :season=>"20122013",
                :type=>"Postseason",
                :venue=>"Toyota Stadium",
                :venue_link=>"/api/v1/venues/null"}

    assert_equal expected, @stat_tracker.find_all_games_from_season("20122013")[0]
  end


end
