require_relative 'test_helper'

class GamesCollectionTest < Minitest::Test

  def setup
    @game_hash_1 = {
                  game_id: 2012030221,
                  season: 20122013,
                  type: 'Postseason',
                  date_time: '5/16/13',
                  away_team_id: 3,
                  home_team_id: 6,
                  away_goals: 2,
                  home_goals: 3,
                  venue: 'Toyota Stadium',
                  venue_link: '/api/v1/venues/null'
                }
    @game_1 = Game.new(@game_hash_1)
    @game_hash_2 = {
                  game_id: 2012030224,
                  season: 20122014,
                  type: 'Postseason',
                  date_time: '5/16/14',
                  away_team_id: 5,
                  home_team_id: 2,
                  away_goals: 1,
                  home_goals: 4,
                  venue: 'Toyota Stadium',
                  venue_link: '/api/v1/venues/null'
                }
    @game_2 = Game.new(@game_hash_2)
    @games_array = [@game_1, @game_2]
    @games_collection = GamesCollection.new(@games_array)
  end

  def test_it_exists
    assert_instance_of GamesCollection, @games_collection
  end

  def test_it_initializes_attributes
    assert_equal @games_array, @games_collection.games
  end
end
