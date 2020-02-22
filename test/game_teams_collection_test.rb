require 'csv'
require './lib/game_teams'
require './lib/game_teams_collection'
require 'minitest/autorun'
require 'minitest/pride'

class GameTeamsCollectionTest < Minitest::Test

  def setup
    @game_team_data = CSV.read('./data/little_game_teams.csv',
                              headers: true,
                              header_converters: :symbol)
    @gtc = GameTeamsCollection.new(@game_team_data)
  end

  def test_it_exists
    assert_instance_of GameTeamsCollection, @gtc
  end

  def test_it_can_create_an_array_of_game_team_objects
    assert_instance_of Array, @gtc.game_teams
    assert_instance_of GameTeams, @gtc.game_teams.first
  end

  def test_it_has_as_many_teams_as_data_lines
    assert_equal @gtc.game_teams.size, @game_team_data.size
  end

  def test_it_has_real_data
    assert_equal 44.8, @gtc.game_teams.first.face_off_win_percentage
    assert_equal 2012030221, @gtc.game_teams.first.game_id
    assert_equal 17, @gtc.game_teams.first.giveaways
    assert_equal 2, @gtc.game_teams.first.goals
    assert_equal "John Tortorella", @gtc.game_teams.first.head_coach
    assert_equal "away", @gtc.game_teams.first.hoa
    assert_equal 8, @gtc.game_teams.first.pim
    assert_equal 0, @gtc.game_teams.first.power_play_goals
    assert_equal 3, @gtc.game_teams.first.power_play_opportunities
    assert_equal "LOSS", @gtc.game_teams.first.result
    assert_equal "OT", @gtc.game_teams.first.settled_in
    assert_equal 8, @gtc.game_teams.first.shots
    assert_equal 44, @gtc.game_teams.first.tackles
    assert_equal 7, @gtc.game_teams.first.takeaways
    assert_equal 3, @gtc.game_teams.first.team_id
  end
end
