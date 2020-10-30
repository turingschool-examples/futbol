require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/seasons_collection'

class SeasonCollectionTest < Minitest::Test
    def setup
        @seasonids = ["20122013","20132014"]
        @teamids =  %w[1 4 26 14 6 3 5 17 28 18 23 16 9 8 30 15 19 24 27 2 20 21 25 13 10 29 52 54 12 7 22 53]

        @seasoncollection = SeasonCollection.new('./data/game_teams_dummy.csv', @seasonids, @teamids, self)
    end

    def test_it_exsist_and_has_attributes

        assert_instance_of SeasonCollection, @seasoncollection
        assert_equal 64, @seasoncollection.seasons.count
    end

    def test_map_seasons_by_team

        actual = @seasoncollection.map_seasons_by_team


        assert_instance_of Hash, actual

        actual.each do |team, season|
            assert_instance_of String, team
            assert_instance_of Hash, season
        end
    end
end
