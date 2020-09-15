require_relative 'test_helper'

class GameTeamsTest < Minitest::Test

  def test_it_exists_with_attributes
    game_team = GameTeams.new({game_id: 1,
                     season: "2012",
                     type: "OT",
                     date_time: "9/1/20",
                     away_team_id: "7",
                     home_team_id: "3",
                     away_goals: 5,
                     home_goals: 1})

    assert_instance_of GameTeams, game_team
  end
end
