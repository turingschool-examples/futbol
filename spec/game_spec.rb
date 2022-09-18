require "rspec"
require './lib/stat_tracker'
require "./lib/team"
require "./lib/game"

RSpec.describe Game do
  let(:game) {Game.new(["2012030221", "20122013", "Postseason", "5/16/13", "3", "6", "2", "3", "Toyota Stadium", "/api/v1/venues/null"])}
  
  it "exists" do
    expect(game).to be_a Game
  end
  
  it "has an attribute storing game data in a hash" do
    expect(game.info).to be_a Hash
    expect(game.info.keys).to eq([:'2012030221'])
    expect(game.info[:'2012030221']).to eq({season: "20122013", type: "Postseason", date_time: "5/16/13", away_team_id: "3", home_team_id: "6", away_goals: "2", home_goals: "3", venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"})
  end
end