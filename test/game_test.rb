require './test/test_helper'
require './lib/game'

class GameTest < Minitest::Test

  def setup
    @game_hash = {
      id: 2012030221,
      season: 20122013,
      type: "Postseason",
      date_time: "5/16/13",
      venue: "Toyota Stadium",
      venue_link: "/api/v1/venues/null",
      away_team: {
        team_id: 3,
        hoa: "away",
        result: "LOSS",
        head_coach: "John Tortorella",
        goals: 2,
        shots: 8,
        tackles: 44,
        pim: 8,
        power_play_opportunities: 3,
        power_play_goals: 0,
        face_off_win_percentage: 44.8,
        giveaways: 17,
        takeaways: 7
      },
      home_team: {
        team_id: 6,
        hoa: "home",
        result: "WIN",
        head_coach: "Claude Julien",
        goals: 3,
        shots: 12,
        tackles: 51,
        pim: 6,
        power_play_opportunities: 4,
        power_play_goals: 1,
        face_off_win_percentage: 55.2,
        giveaways: 4,
        takeaways: 5
      }
    }
    @game = Game.new(@game_hash)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_attributes
    assert_equal @game_hash[:id], @game.id
    assert_equal @game_hash[:season], @game.season
    assert_equal @game_hash[:type], @game.type
    assert_equal @game_hash[:date_time], @game.date_time
    assert_equal @game_hash[:venue], @game.venue
    assert_equal @game_hash[:venue_link], @game.venue_link
    assert_equal @game_hash[:home_team], @game.home_team
    assert_equal @game_hash[:away_team], @game.away_team
  end
end
