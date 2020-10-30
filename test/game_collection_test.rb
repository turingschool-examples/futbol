require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'
require './lib/stat_tracker'
require 'mocha/minitest'

class GameCollectionTest < Minitest::Test
  def setup
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
              }

    stat_tracker     = mock('stat_tracker')
    @game_collection = GameCollection.new(game_path, stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameCollection, @game_collection
  end
end
