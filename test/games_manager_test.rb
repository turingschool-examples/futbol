require_relative 'test_helper'
require_relative '../lib/helpable'
require 'mocha/minitest'

class GamesManagerTest < Minitest::Test
  include Helpable

  def test_it_exists
    games_manager = GamesManager.new(setup)

    assert_instance_of GamesManager, games_manager
  end

  def test_it_can_find_the_highest_total_score
    games_manager = GamesManager.new(setup)

    assert_equal 6, games_manager.highest_total_score
  end

  def test_lowest_total_score
    games_manager = GamesManager.new(setup)

    assert_equal 1, games_manager.lowest_total_score
  end
end
