require "minitest/autorun"
require "minitest/pride"
require "./lib/create_hash"
require 'csv'
require 'pry'

class CreateHashTest < MiniTest::Test

  def setup
    game_path = './data/dummy_file_games.csv'
    team_path = './data/dummy_file_teams.csv'
    game_teams_path = './data/dummy_file_game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
  end

  def test_it_exists
    new_hash = CreateHash.new

    assert_instance_of CreateHash, new_hash
  end

  def test_create_hash_keys
    array_dummy = CSV.read('./data/dummy_file_games.csv')
    new_hash = CreateHash.new()
    new_hash.create_stat_hash_keys(array_dummy)

    assert_equal 10, new_hash.stat_hash.keys.size
  end

  def test_create_stat_hash_values
    array_dummy = CSV.read('./data/dummy_file_games.csv')
    new_hash = CreateHash.new()
    new_hash.create_stat_hash_keys(array_dummy)

    assert_equal 19, new_hash.stat_hash["game_id"].size
  end
end
