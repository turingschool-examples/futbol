require "minitest/autorun"
require "minitest/pride"
require './lib/seasons_collection'

class SeasonsCollectionTest < Minitest::Test
  def setup
    @seasons_collection = SeasonsCollection.new('./data/game_teams.csv', )
  end
end
