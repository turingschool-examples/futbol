require_relative './test_helper'
require './lib/game_team'
require 'csv'

class GameTeamTest < Minitest::Test

  def setup
    @game_teams = []
    CSV.foreach('./data/game_teams.csv', headers: true, header_converters: :symbol) do |row|
      @game_teams << GameTeam.new(row)
    end
  end

  def test_it_exists_and_has_attributes
    gameteam = @game_teams.first
    assert_instance_of GameTeam, gameteam
    assert_equal "2012030221", gameteam.game_id
    assert_equal "3", gameteam.team_id
    assert_equal "away", gameteam.hoa
    assert_equal "LOSS", gameteam.result
    assert_equal "OT", gameteam.settled_in
    assert_equal "John Tortorella", gameteam.head_coach
    assert_equal 2, gameteam.goals
    assert_equal 8, gameteam.shots
    assert_equal 44, gameteam.tackles
    assert_equal 8, gameteam.pim
    assert_equal 3, gameteam.powerplayopportunities
    assert_equal 0, gameteam.powerplaygoals
    assert_equal 44.8, gameteam.faceoffwinpercentage
    assert_equal 17, gameteam.giveaways
    assert_equal 7, gameteam.takeaways
  end
end
