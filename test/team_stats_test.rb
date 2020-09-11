require_relative 'test_helper'
require "./lib/game_statistics"
require "./lib/team_stats"
require './lib/stat_tracker'
require './lib/season_stats'

class TeamStatsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    @raw_game_stats = @stat_tracker.game_stats
    @raw_game_teams_stats = @stat_tracker.game_teams_stats
    @raw_team_stats = @stat_tracker.teams_stats
    @season_stats = SeasonStatistics.new(@raw_game_stats, @raw_game_teams_stats, @raw_team_stats)
    @team_stats = TeamStats.new(@season_stats)
  end

  # def test_it_exists
  #   assert_instance_of TeamStats, @team_stats
  # end

  def test_in_can_find_team_info
    expected = {"team_id"=>"54", "franchiseid"=>"38", "teamname"=>"Reign FC",
      "abbreviation"=>"RFC", "stadium"=>"Cheney Stadium", "link"=>"/api/v1/teams/54"}
    assert_equal expected, @team_stats.team_info(54)
  end
end
