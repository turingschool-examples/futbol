require 'spec_helper'



describe Game do
  it "exists" do
  info = {
    game_id: "1",
    season: "374",
    type: "Postseason",
    date_time: "5/16/13",
    away_team_id: "5",
    home_team_id: "7",
    away_goals: "3",
    home_goals: "1",
    venue: "Toyota Stadium",
    venue_link: "/api/v1/venues/null"
  }
    game = Game.new(info)

    expect(game).to be_a Game
  end
end
