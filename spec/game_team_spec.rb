require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/game_team'

describe GameTeam do

  before(:each) do
    @game_team1 = GameTeam.new("2012030221","3","away","LOSS","OT","John Tortorella","2","8","44","8","3","0","44.8","17","7")

  end

  it 'exists' do
    expect(@game_team1).to be_a(GameTeam)
  end

  it 'has readable attributes' do
    expect(@game_team1.game_id).to eq("2012030221")
    expect(@game_team1.team_id).to eq("3")
    expect(@game_team1.takeaways).to eq("7")
  end

end
