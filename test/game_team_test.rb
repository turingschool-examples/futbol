require_relative './test_helper'
require './lib/game_team'

class GameTeamTest < Minitest::Test
  def setup
    sample_hash = {:game_id=>"2012020122",
                       :team_id=>"3",
                       :hoa=>"away",
                       :result=>"WIN",
                       :settled_in=>"REG",
                       :head_coach=>"Peter DeBoer",
                       :goals=>"3",
                       :shots=>"6",
                       :tackles=>"19",
                       :pim=>"21",
                       :powerplayopportunities=>"3",
                       :powerplaygoals=>"1",
                       :faceoffwinpercentage=>"46.6",
                       :giveaways=>"6",
                       :takeaways=>"9"
                      }
    @gameteam = GameTeam.new(sample_hash, self)
  end

  def test_it_exists
    assert_instance_of GameTeam, @gameteam
  end

  def test_attributes
    assert_equal "2012020122", @gameteam.game_id
    assert_equal "3", @gameteam.team_id
    assert_equal "away", @gameteam.hoa
    assert_equal "WIN", @gameteam.result
    assert_equal "Peter DeBoer", @gameteam.head_coach
    assert_equal 3, @gameteam.goals
    assert_equal 6, @gameteam.shots
    assert_equal 19, @gameteam.tackles
  end
end
