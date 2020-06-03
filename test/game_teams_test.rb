require 'csv'
require_relative 'test_helper'
require './lib/game_teams'

class GameTeamsTest < MiniTest::Test
  def setup
    @game_teams = GameTeams.new({game_id: "2012030223",
                                team_id: "6",
                                hoa: "away",
                                result: "WIN",
                                settled_in: "REG",
                                head_coach: "Claude Julien",
                                goals: "2",
                                shots: "8",
                                tackles: "28",
                                pim: "6",
                                powerplayopportunities: "0",
                                powerplaygoals: "0",
                                faceoffwinpercentage: "61.8",
                                giveaways: "10",
                                takeaways: "7"
      })
  end

  def test_it_exists
    assert_instance_of GameTeams, @game_teams
  end

  def test_it_has_attributes
    assert_equal "Claude Julien", @game_teams.head_coach
    assert_equal "2", @game_teams.goals
    assert_equal "0", @game_teams.power_play_goals
  end
end
