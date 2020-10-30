require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/seasons_collection'
require "mocha/minitest"
require 'csv'

class SeasonsCollectionTest < Minitest::Test
  def setup
    parent = mock("stat_tracker")
    parent.stubs(:find_season_id).returns("20122013")

    @seasonids = ["20122013","20132014"]
    @teamids =  ["6", "3"]
    @filepath = './data/game_teams_dummy.csv'
    @seasoncollection = SeasonsCollection.new(@filepath, @seasonids, @teamids, parent)
  end

  def test_it_exists_and_has_attributes

    assert_instance_of SeasonsCollection, @seasoncollection
    assert_equal 4, @seasoncollection.seasons.count
  end

  def test_find_season_id

    actual = @seasoncollection.find_season_id("2012020122")

    assert_instance_of String, actual
    assert_equal "20122013", actual
  end

  def test_map_seasons_by_team

    actual = @seasoncollection.map_seasons_by_team

    assert_instance_of Hash, actual

    actual.each do |team, season|
      assert_instance_of String, team
      assert_includes ["3", "6"], team
      assert_instance_of Hash, season
      season.each do |id, games_array|
        assert_includes ["20122013", "20132014"], id
        assert_equal [], games_array
      end
    end
  end

  def test_seasons_by_team

    actual = @seasoncollection.seasons_by_team(@filepath)
    assert_instance_of Hash, actual
    actual.each do |team, season|
      assert_instance_of String, team
      assert_includes ["3", "6"], team
      assert_instance_of Hash, season
      season.each do |id, games_array|
        assert_includes ["20122013", "20132014"], id
        assert_instance_of Hash, games_array[0]
        break
      end
    end
  end

  def test_create_seasons

    @seasoncollection.seasons.each do |season|
      assert_instance_of Season, season
    end
  end
end
