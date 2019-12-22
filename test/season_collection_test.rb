require_relative './test_helper'
require './lib/season'
require './lib/collection'
require './lib/season_collection'
require 'csv'

class SeasonTest < Minitest::Test
  def setup
    @season_collection = SeasonCollection.new('./test/fixtures/games_truncated.csv')
    @season = @season_collection.collection
  end

  def test_team_collection_exists
    assert_instance_of SeasonCollection, @season_collection
  end

  def test_game_collection_has_games
    assert_instance_of Hash, @season_collection.collection
    assert_equal 5, @season_collection.collection.length
  end

  def test_game_collection_can_create_games_from_csv
    assert_instance_of Season, @season["20122013"][0]
    assert_equal '17', @season["20122013"][0].home_team_id
    assert_equal 'Postseason', @season["20122013"][0].type
    assert_equal '1', @season["20122013"][0].away_goals
  end
end
