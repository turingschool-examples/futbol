require './test/test_helper'
require './lib/game'
require './lib/team'
require './lib/season'

class SeasonTest < Minitest::Test

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

    @team_hash = {
      team_id: 1,
      franchiseId: 23,
      teamName: "Atlanta United",
      abbreviation: "ATL",
      Stadium: "Mercedes-Benz Stadium",
      link: "/api/v1/teams/1",
      games: {
        @game.id => @game
      }
    }
    @team = Team.new(@team_hash)

    @season_hash = {
      season_id: 20122013
      teams: {
        @team.id => @team,
        games: { 
          @game.id => @game
        }
      }
    }
   
   @season = Season.new(@season_hash)
  end

  def test_it_exists
    assert_instance_of Season, @season
  end

  def test_it_has_attributes
    # assert_equal @season_hash[:season_id] = @season.season_id
    # assert_equal @season_hash[:teams] = 
  end

end
