require 'minitest/autorun'
require 'minitest/pride'
require './lib/stat_tracker'
require 'mocha/minitest'
require './lib/game_teams_repo'

class GameTeamsRepoTest < Minitest::Test
  def setup
    game_teams_path = './data/game_teams.csv'

    locations = {
      game_teams: game_teams_path
    }
    @parent = mock()
    @game_teams_repo = GameTeamsRepo.new(locations[:game_teams_path], @parent)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Array, @game_teams_repo.game_teams
    assert mock(), @parent
  end

  def test_create_game_teams
    assert_instance_of GameTeams, @game_teams_repo.game_teams[0]
  end

  def test_count_of_teams
    assert_equal 32, @game_teams_repo.count_of_teams
  end
end
