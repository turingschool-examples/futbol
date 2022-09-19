require "rspec"
require './lib/stat_tracker'
require "./lib/team"
require "./lib/game"

RSpec.describe Game do
  game_csv_row = ["2012030221", "20122013", "Postseason", "5/16/13", "3", "6", "2", "3", "Toyota Stadium", "/api/v1/venues/null"]
  game_teams_csv_row1 = ["2012030221", "3", "away", "LOSS", "OT", "John Tortorella", "2", "8", "44", "8", "3", "0", "44.8", "17", "7"]
  game_teams_csv_row2 = ["2012030221", "6", "home", "WIN", "OT", "Claude Julien", "3", "12", "51", "6", "4", "1", "55.2", "4", "5"]
  let(:game) {Game.new(game_csv_row, game_teams_csv_row1, game_teams_csv_row2)}
  
  it "exists" do
    expect(game).to be_a Game
  end
  
  it "has readable attributes" do
    expect(game.game_id).to eq('2012030221')
    expect(game.season).to eq('20122013')
    expect(game.away_goals).to eq(2)
    expect(game.home_goals).to eq(3)
  end
  
  it "has readable hash attributes for away_team and home_team information" do
    expect(game.away_team).to be_a Hash
    expect(game.home_team).to be_a Hash
    expect(game.away_team[:team_id]).to eq('3')
    expect(game.away_team[:result]).to eq('LOSS')
    expect(game.away_team[:head_coach]).to eq('John Tortorella')
    expect(game.away_team[:shots]).to eq(8)
    expect(game.away_team[:tackles]).to eq(44)
  end
end