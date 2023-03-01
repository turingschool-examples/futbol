require_relative 'spec_helper'
RSpec.describe Game do
  before(:each) do
    @game = Game.new({:id => 2012030221,
      :season => 20122013,
      :season_type => 'Postseason',
      :date => "5/16/13",
      :away_id => 3,
      :home_id => 6,
      :away_goals => 2,
      :home_goals => 3
      })
  end

  it 'exists' do
    expect(@game).to be_a Game
  end

  it 'has attributes' do
    expect(@game.id).to eq(2012030221)
    expect(@game.season).to eq(20122013)
    expect(@game.season_type).to eq('Postseason')
    expect(@game.date).to eq("5/16/13")
    expect(@game.away_id).to eq(3)
    expect(@game.home_id).to eq(6)
    expect(@game.away_goals).to eq(2)
    expect(@game.home_goals).to eq(3)
  end
end