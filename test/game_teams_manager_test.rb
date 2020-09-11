require_relative 'test_helper'

class GameTeamsStatsTest < Minitest::Test
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
  @game_statistics = GameTeamsStats.new('./data/game_teams.csv', @stat_tracker)
  require "pry"; binding.pry
  end

  def test_it_exists
    assert_instance_of GameTeamsStats, @game_statistics
  end
end
