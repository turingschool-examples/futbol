require './test/test_helper'

class GameCollectionTest < Minitest::Test
  def setup
    @game_collection = GameCollection.new('./test/data/game_sample.csv')
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_read_csv
    expected = {
      game_id: "1",
      season: "20192020",
      type: "Regular Season",
      date_time: "10/22/19",
      away_team_id: "3",
      home_team_id: "5",
      away_goals: 8,
      home_goals: 4,
      venue: "Sports Authority Field",
      venue_link: "/api/v1/venues/null"
    }
    assert_equal 10, @game_collection.games.count
  end

  def test_total_games
    assert_equal 10, @game_collection.total_games
  end
end
