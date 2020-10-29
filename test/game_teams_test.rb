require 'CSV'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/game_teams_repo'
require './lib/game_teams'

class GameTeamsTest < Minitest::Test
  def setup
    game_teams_path = './data/game_teams.csv'
    locations = {game_teams:game_teams_path}
    row = CSV.readlines('./data/game_teams.csv', headers: :true, header_converters: :symbol)[0]
    @parent = mock('game_teams_repo')
    @game_teams1 = GameTeams.new(row, @parent)
  end

  def test_it_exists_and_has_attributes
    assert_equal "2012030221", @game_teams1.game_id
    assert_equal 3, @game_teams1.team_id
    assert_equal "away", @game_teams1.hoa
    assert_equal "LOSS", @game_teams1.result
    assert_equal "OT", @game_teams1.settled_in
    assert_equal "John Tortorella", @game_teams1.head_coach
    assert_equal 2, @game_teams1.goals
    assert_equal 8, @game_teams1.shots
    assert_equal 44, @game_teams1.tackles

    assert mock(), @game_teams1.parent
  end
end
