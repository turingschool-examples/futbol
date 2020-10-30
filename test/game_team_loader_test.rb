require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team_loader'
require './lib/stat_tracker'
require './lib/game_team'

class GameTeamLoaderTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)
    @game_team_loader = GameTeamLoader.new(game_team_path, stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamLoader, @game_team_loader
  end
end
