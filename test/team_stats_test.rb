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
    expected = {
      'team_id' => '18',
      'franchise_id' => '34',
      'team_name' => 'Minnesota United FC',
      'abbreviation' => 'MIN',
      'link' => '/api/v1/teams/18'
    }
    assert_equal expected, @stat_tracker.team_info('18')
  end

  def test_average_win_percentage
    assert_equal 0.49, @stat_tracker.average_win_percentage('6')
  end

  def test_all_team_games
    expected = @stat_tracker.all_team_games('18').first

    assert_equal expected, @stat_tracker.all_team_games('18')[0]
  end

  def test_team_biggest_blowout
    assert_equal 5, @stat_tracker.biggest_team_blowout('18')
  end
end
