require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/season'

class TestSeasonCLASS < Minitest::Test
    def setup
        sample_gameteam = {game_id: "2012020122", goals: "3", head_coach:"Peter DeBoer", hoa:"away",  result: "WIN", shots: "6", tackles:"19"}
        @season = Season.new("3","20122013", sample_gameteam, self)
    end

    def test_it_exsist

        assert_instance_of Season, @season
    end
end