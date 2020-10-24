require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_statistics'

class GameStatsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    dummy_path = './data/dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path,
      dummy: dummy_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    @dummy_stats = stat_tracker[:dummy]
    @game = GameStats.new(@dummy_stats)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameStats, @game
    assert_equal @dummy_stats, @game.stats
  end

  def test_it_can_sum_data
    goals_sum = 19

    assert_equal goals_sum, @game.sum_data(:goals)
  end
end
