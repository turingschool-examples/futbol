require 'csv'
require './test/test_helper'
require './lib/game_team'

class GameTeamTest < Minitest::Test

  def setup
    csv = CSV.read('./data/game_teams_sample.csv', headers: true, header_converters: :symbol)
    @game_teams = csv.map do |row|
      GameTeam.new(row)
    end
  end

  def test_it_exists
    @game_teams.each do |row|
      assert_instance_of GameTeam, row
    end
  end

  def test_it_has_attributes
    assert_equal 2012030221, @game_teams.first.game_id
    assert_equal 3, @game_teams.first.team_id
    assert_equal "away", @game_teams.first.hoa
    assert_equal "LOSS", @game_teams.first.result
    assert_equal "OT", @game_teams.first.settled_in
    assert_equal "John Tortorella", @game_teams.first.head_coach
    assert_equal 2, @game_teams.first.goals
    assert_equal 8, @game_teams.first.shots
    assert_equal 44, @game_teams.first.tackles
    assert_equal 8, @game_teams.first.pim
    assert_equal 3, @game_teams.first.powerplayopportunities
    assert_equal 0, @game_teams.first.powerplaygoals
    assert_equal 44.8, @game_teams.first.faceoffwinpercentage
    assert_equal 17, @game_teams.first.giveaways
    assert_equal 7, @game_teams.first.takeaways
  end
end
