require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/team_collection'
require './lib/stat_tracker'
require 'mocha/minitest'

class TeamCollectionTest < Minitest::Test
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
    @team_collection = TeamCollection.new(team_path, stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of TeamCollection, @team_collection
  end

  def test_find_team
    assert_equal "Houston Headbangers", @team_collection.find_team("3")
  end
end
