require './test/test_helper'
require './lib/game_team'
require 'CSV'
require 'pry'

class GameTeamTest < Minitest::Test

  def setup
    @csv_game_teams = CSV.read('./data/game_teams_fixture.csv', headers: true, header_converters: :symbol)
    @game_team = GameTeam.new(@csv_game_teams[0])
  end

  def test_it_exists
    assert_instance_of GameTeam, @game_team
  end

  def test_it_has_readable_attributes
    assert_equal "2012030221", @game_team.game_id
    assert_equal "3", @game_team.team_id
    assert_equal "away", @game_team.home_or_away
    assert_equal "LOSS", @game_team.result
    assert_equal "OT", @game_team.settled_in
    assert_equal "John Tortorella", @game_team.head_coach
    assert_equal 2, @game_team.goals
    assert_equal 8, @game_team.shots
    assert_equal 44, @game_team.tackles
    assert_equal 8, @game_team.pim
    assert_equal 3, @game_team.power_play_opportunities
    assert_equal 0, @game_team.power_play_goals
    assert_equal 44.8, @game_team.face_off_win_percentage
    assert_equal 17, @game_team.give_aways
    assert_equal 7, @game_team.takeaways
  end
end

# game_id,team_id,HoA,result,settled_in,head_coach,goals,shots,tackles,pim,powerPlayOpportunities,powerPlayGoals,faceOffWinPercentage,giveaways,takeaways
#
# 2012030221,3,away,LOSS,OT,John Tortorella,2,8,44,8,3,0,44.8,17,7
