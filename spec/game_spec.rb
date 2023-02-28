require 'spec_helper'
describe Game do
  it 'is an instance of Game' do
    game = Game.new(2012030221,20122013,"Postseason","5/16/13",3,6,2,3,"Toyota Stadium","/api/v1/venues/null")
    expect(game.id).to eq(2012030221)
    expect(game.season).to eq(20122013)
    expect(game.type).to eq("Postseason")
    expect(game.date_time).to eq("5/16/13")
    expect(game.away).to eq(3)
    expect(game.home).to eq(6)
    expect(game.away_goals).to eq(2)
    expect(game.home_goals).to eq(3)
    expect(game.venue).to eq("Toyota Stadium")
    expect(game.venue_link).to eq("/api/v1/venues/null")
  end
end