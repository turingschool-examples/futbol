require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def test_it_exists

    game_path = './fixture/games_dummy15.csv'
    team_path = './fixture/teams_dummy15.csv'
    game_team_path = './fixture/game_teams_dummy15.csv'

    tracker = StatTracker.new(game_path, team_path, game_team_path)

    assert_instance_of StatTracker, tracker
  end

  ####### Game Stats ########

  ###########################

  ###### Team Stats #########

  ###########################

  ###### League Stats #######

  ###########################

  ###### Season Stats #######

  ###########################
end
