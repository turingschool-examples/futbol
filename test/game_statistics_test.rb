require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require './lib/game_statistics'

class GameStats < Minitest::Test
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
    dummy_stats = stat_tracker[:dummy]
    @game = GameStats.new()
  end

  def test_it_exists_and_has_attributes
  end
end
