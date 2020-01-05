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

class SeasonStatsTest < Minitest::Test
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

  def test_biggest_bust_method
    skip
    assert_equal 'Montreal Impact', @stat_tracker.biggest_bust('20132014')
    assert_equal 'Sporting Kansas City', @stat_tracker.biggest_bust('20142015')
  end

  def test_season_stats_can_get_winningest_coach
    assert_equal 'Claude Julien', @stat_tracker.winningest_coach('20132014')
    assert_equal 'Alain Vigneault', @stat_tracker.winningest_coach('20142015')
  end

  def test_season_stats_can_get_worst_coach
    assert_equal 'Peter Laviolette', @stat_tracker.worst_coach('20132014')
    assert_equal 'Craig MacTavish', @stat_tracker.worst_coach('20142015')
  end
end
