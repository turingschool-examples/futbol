require "minitest/autorun"
require "minitest/pride"
require "./lib/data_object_creatable"
include DataObjectCreatable

class DataObjectCreatableTest < Minitest::Test

  def test_instances_of_game
    game_data = DataObjectCreatable.create_instances_of_game
    assert_equal 19, game_data.size
  end

  def test_instances_of_team
    team_data = DataObjectCreatable.create_instances_of_team
    assert_equal 19, team_data.size
  end

end
