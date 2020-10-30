require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/season'

class SeasonTest < Minitest::Test
    def setup
      sample_gameteam = {:game_id=>"2012020122",
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
      @season = Season.new("3","20122013", [sample_gameteam], self)
    end

    def test_it_exists

      assert_instance_of Season, @season
    end

    def test_attributes

      assert_equal "3", @season.team_id
      assert_equal "20122013", @season.season_id
      assert_instance_of Array, @season.game_teams
      @season.game_teams.each do |game_team|
        assert_instance_of Hash, game_team
      end
      assert_equal "2012020122", @season.game_teams[0][:game_id]
    end
end
