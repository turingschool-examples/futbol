require "./test/test_helper"
# require 'minitest/pride'
# require 'minitest/autorun'
# require './lib/game_team_manager'
# require 'csv'
# require 'pry'

class GameTeamManagerTest < Minitest::Test
  def setup
    @game_team_manager = GameTeamManager.new(CSV.parse(File.read("./data/games_to_test.csv"), headers: true))
  end

  def test_it_exists
    assert_instance_of GameTeamManager, @game_team_manager
  end
