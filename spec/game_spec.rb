require 'spec_helper.rb'

RSpec.describe Game do
  it "can initialize" do
    game = Game.new("20122013", "3", "6", "2", "3")

    # expect(game.game_id).to eq "2012030221"
    expect(game.season_id).to eq "20122013"
    expect(game.away_team_id).to eq "3"
    expect(game.home_team_id).to eq "6"
    expect(game.away_goals).to eq "2"
    expect(game.home_goals).to eq "3"
  end
end
