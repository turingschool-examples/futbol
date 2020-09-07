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

  def test_array_of_game_id_from_season
#should add more tests here
    assert_equal "2012030221", @stat_tracker.array_of_game_id_from_season("20122013")[0]
  end

  def test_find_game_teams_data_for_season
    # expected = <GameTeams:0x00007f898640b318
    #           @HoA="away",
    #           @faceOffWinPercentage=44.8,
    #           @game_id="2012030221",
    #           @giveaways=17,
    #           @goals=2,
    #           @head_coach="John Tortorella",
    #           @pim=8,
    #           @powerPlayGoals=0,
    #           @powerPlayOpportunities=3,
    #           @result="LOSS",
    #           @settled_in="OT",
    #           @shots=8,
    #           @tackles=44,
    #           @takeaways=7,
    #           @team_id="3">
    assert_equal [], @stat_tracker.game_teams_data_for_season("20122013")[0]
  end
end
