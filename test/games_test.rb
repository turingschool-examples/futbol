require './test/test_helper'
require './lib/games'

class GamesTest < Minitest::Test

  def setup
    @new_game = Games.new({
      game_id: 2012030221,
      season: 20122013,
      type: "Postseason",
      date_time: "5/16/13",
      away_team_id: 3,
      home_team_id: 6,
      away_goals: 2,
      home_goals: 3,
      venue: "Toyota Stadium"
    })

    Games.from_csv('./data/games.csv')

    @game = Games.all[1]
  end

  def test_it_exists
    assert_instance_of Games, @game
  end
end
