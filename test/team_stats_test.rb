require_relative './test_helper'
require 'csv'
require './lib/tracker'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_teams'
require './lib/season'
require './lib/collection'
require './lib/game_collection'
require './lib/team_collection'
require './lib/game_teams_collection'
require './lib/season_collection'

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

    @stat_tracker = Tracker.from_csv(locations)
  end

  def test_team_info
    expected = {"team_id"=>"6", "franchise_id"=>"6", "team_name"=>"FC Dallas", "abbreviation"=>"DAL", "link"=>"/api/v1/teams/6"}
    assert_equal expected, @stat_tracker.team_info('6')
  end

  def test_average_win_percentage
    require 'pry'; binding.pry
  end
end
