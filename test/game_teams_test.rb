require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_teams'

class GameTeamsTest < Minitest::Test

  def setup
    @test_data = CSV.read('./data/little_game_teams.csv', headers: true, header_converters: :symbol)
    @game_teams = @test_data.map do |row|
      GameTeams.new(row.to_h)
    end
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams.first
  end

  def test_it_contains_game_data
    assert_equal 2012030221, @game_teams.first.game_id
    assert_equal 3, @game_teams.first.team_id
    assert_equal "away", @game_teams.first.hoa
    assert_equal "LOSS", @game_teams.first.result
    assert_equal "OT", @game_teams.first.settled_in
    assert_equal "John Tortorella", @game_teams.first.head_coach
    assert_equal 0, @game_teams.first.goals
    assert_equal 8, @game_teams.first.shots
    assert_equal 44, @game_teams.first.tackles
    assert_equal 8, @game_teams.first.pim
    assert_equal 3, @game_teams.first.power_play_opportunities
    assert_equal 0, @game_teams.first.power_play_goals
    assert_equal 44.8, @game_teams.first.face_off_win_percentage
    assert_equal 17, @game_teams.first.giveaways
    assert_equal 7, @game_teams.first.takeaways
  end

end
