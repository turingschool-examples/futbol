require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/season_collections'

class SeasonCollectionTest < Minitest::Test
    def setup
        seasonids = ["20122013","20132014"]
        teamids =  %w[1 4 26 14 6 3 5 17 28 18 23 16 9 8 30 15 19 24 27 2 20 21 25 13 10 29 52 54 12 7 22 53]
        
        @seasoncollection = SeasonCollection.new('./data/game_teams_dummy.csv', seasonids, teamids, self)

        assert_instance_of SeasonCollection, seasoncollection
    end
end