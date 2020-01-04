require_relative './test_helper'
require './lib/season'
require './lib/collection'
require './lib/season_collection'
require 'csv'

class SeasonTest < Minitest::Test
  def setup
    @seasons = SeasonCollection.new('./test/fixtures/games_truncated.csv')
    @season = @seasons.collection
  end

  def test_team_collection_exists
    assert_instance_of SeasonCollection, @seasons
  end

  def test_game_collection_has_games
    assert_instance_of Hash, @seasons.collection
    assert_equal 5, @seasons.collection.length
  end

  def test_game_collection_can_create_games_from_csv
    assert_instance_of Season, @season['20122013'][0]
    assert_equal '17', @season['20122013'][0].home_team_id
    assert_equal 'Postseason', @season['20122013'][0].type
    assert_equal '1', @season['20122013'][0].away_goals
  end
end
