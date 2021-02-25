require 'CSV'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @game_path = './dummy_data/games_dummy.csv'
    @team_path = './dummy_data/teams_dummy.csv'
    @game_teams_path = './dummy_data/game_teams_dummy.csv'
    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
  @fake_games_data = CSV.parse(File.read(@locations[:games]), headers: true)
  end

  def test_it_exists
    game = Game.new(@fake_games_data[0])
    assert_instance_of Game, game
  end
end
