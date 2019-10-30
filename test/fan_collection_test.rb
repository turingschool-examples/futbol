require_relative 'test_helper'
require './lib/fan_collection'
require './lib/stat_tracker'

class FanTest < Minitest::Test
  def setup
    @fan = Fan.new("./test/test_game_team_data.csv", "./data/teams.csv")
    @game_teams = GameTeamCollection.new("./test/test_game_team_data.csv")
    @teams = TeamCollection.new("./data/teams.csv")
  end

  def test_it_exists
    assert_instance_of Fan, @fan
  end

  def test_it_can_create_game_teams
    assert_equal 6, @game_teams.game_teams[0].team_id
  end

  def test_it_can_create_teams
    assert_equal "DC United", @teams.teams[3].teamName
  end

  def test_best_fans_team_id
    assert_equal 6, @fan.best_fans_team_id
  end

  def test_best_fans
    assert_equal "FC Dallas", @fan.best_fans
  end

  def test_worst_fans_team_id
    assert_equal [16, 6, 9, 19, 24], @fan.worst_fans_team_id
  end

  def test_worst_fans
    assert_equal ["FC Dallas", "New England Revolution", "New York City FC", "Philadelphia Union", "Real Salt Lake"], @fan.worst_fans
  end
end