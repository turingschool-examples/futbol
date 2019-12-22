require_relative './test_helper'
require './lib/season'
require 'csv'

class SeasonTest < Minitest::Test
  def setup
    @season = mock('Season')
    @season.stubs(:klass).returns('Season')
    @season.stubs(:season).returns('20122013')
    @season.stubs(:game_id).returns('2012030233')
    @season.stubs(:type).returns('Postseason')
    @season.stubs(:date_time).returns('5/20/13')
    @season.stubs(:home_team_id).returns(17)
    @season.stubs(:away_team_id).returns(16)
    @season.stubs(:away_goals).returns(1)
    @season.stubs(:home_goals).returns(3)
    @season.stubs(:venue).returns('Dignity Health Sports Park')
    @season.stubs(:venue_link).returns('/api/v1/venues/null')
  end

  def test_season_exists
    assert_equal 'Season', @season.klass
  end

  def test_season_attributes
    assert_equal '20122013', @season.season
    assert_equal '2012030233', @season.game_id
    assert_equal 'Postseason', @season.type
    assert_equal '5/20/13', @season.date_time
    assert_equal 17, @season.home_team_id
    assert_equal 16, @season.away_team_id
    assert_equal 1, @season.away_goals
    assert_equal 3, @season.home_goals
    assert_equal 'Dignity Health Sports Park', @season.venue
    assert_equal '/api/v1/venues/null', @season.venue_link
  end
end
