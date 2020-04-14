require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'CSV'
require './lib/game_teams'


class GameTeamsTest < Minitest::Test

  def test_it_exists
    game_stats = GameTeams.new({game_id: 12, team_id: 3, hoa: "away",
      result: "LOSS", settled_in: "OT", head_coach: "name", goals: 1, shots: 1,
      tackles: 3, pim: 3, powerplayopportunities: 1, powerplaygoals: 1, faceoffwinpercentage: 4, giveaways: 1, takeaways: 3})
    assert_instance_of GameTeams, game_stats
  end

  def test_has_attributes
    game_stats = GameTeams.new({game_id: 12, team_id: 3, hoa: "away",
      result: "LOSS", settled_in: "OT", head_coach: "name", goals: 1, shots: 1,
      tackles: 3, pim: 3, powerplayopportunities: 1, powerplaygoals: 1,
      faceoffwinpercentage: 4, giveaways: 1, takeaways: 3})
    assert_equal 12, game_stats.game_id
    assert_equal 3, game_stats.team_id
    assert_equal "away", game_stats.hoa
    assert_equal "LOSS", game_stats.result
    assert_equal "OT", game_stats.settled_in
    assert_equal "name", game_stats.head_coach
    assert_equal 1, game_stats.goals
    assert_equal 1, game_stats.shots
    assert_equal 3, game_stats.tackles
    assert_equal 3, game_stats.pim
    assert_equal 1, game_stats.powerplayopportunities
    assert_equal 1, game_stats.powerplaygoals
    assert_equal 4.0, game_stats.faceoffwinpercentage
    assert_equal 1, game_stats.giveaways
    assert_equal 3, game_stats.takeaways
  end



end
