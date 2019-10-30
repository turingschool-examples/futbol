require 'csv'
require './lib/game_teams'
require './lib/stat_tracker'
require './lib/game_teams_collection'
require_relative 'test_helper'

class GameTeamsTest < MiniTest::Test
  def setup
      @game_teams = GameTeams.new({game_id: "2012030221", team_id: 3, hoa: "away", result: "LOSS", settled_in: "OT", head_coach: "John Tortorella", goals: 2, shots: 8, tackles: 4, pim: 8,
      powerplayopportunities: "3", powerplaygoals: "0", faceoffwinpercentage: "44.8", giveaways: "17", takeaways: "7"})
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams
  end

  def test_it_initializes
      assert_equal 2012030221, @game_teams.game_id
      assert_equal 3, @game_teams.team_id
      assert_equal "away", @game_teams.hoa
      assert_equal "LOSS", @game_teams.result
      assert_equal "OT", @game_teams.settled_in
      assert_equal "John Tortorella", @game_teams.head_coach
      assert_equal 2, @game_teams.goals
      assert_equal 8, @game_teams.shots
      assert_equal 4, @game_teams.tackles
      assert_equal 8, @game_teams.pim
      assert_equal 3, @game_teams.powerplayopportunities
      assert_equal 0, @game_teams.powerplaygoals
      assert_equal 44.8, @game_teams.faceoffwinpercentage
      assert_equal 17, @game_teams.giveaways
      assert_equal 7, @game_teams.takeaways
  end
end
