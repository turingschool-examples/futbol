require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'
require './lib/game_team'

describe GameTeam do

  before(:each) do
    @game_team1 = GameTeam.new("2012030221","3","away","LOSS","OT",
      "John Tortorella","2","8","44","8","3","0","44.8","17","7")
  end

  it 'exists' do
    expect(@game_team1).to be_a(GameTeam)
  end

  it 'has readable attributes' do
    expect(@game_team1.game_id).to eq("2012030221")
    expect(@game_team1.team_id).to eq("3")
    expect(@game_team1.hoa).to eq("away")
    expect(@game_team1.result).to eq("LOSS")
    expect(@game_team1.settled_in).to eq("OT")
    expect(@game_team1.head_coach).to eq("John Tortorella")
    expect(@game_team1.goals).to eq("2")
    expect(@game_team1.shots).to eq("8")
    expect(@game_team1.tackles).to eq("44")
    expect(@game_team1.pim).to eq("8")
    expect(@game_team1.power_play_opportunities).to eq("3")
    expect(@game_team1.power_play_goals).to eq("0")
    expect(@game_team1.face_off_win_percentage).to eq("44.8")
    expect(@game_team1.giveaways).to eq("17")
    expect(@game_team1.takeaways).to eq("7")
  end

end
