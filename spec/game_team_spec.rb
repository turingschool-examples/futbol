require './lib/game_team'

RSpec.describe GameTeam do

  it 'exists' do
    info = ["2012030221","3","away","LOSS","OT","John Tortorella","2","8","44","8","3","0","44.8","17","7"]
    game_team = GameTeam.new(info)
    expect(game_team).to be_a(GameTeam)
  end

  it 'data is a hash' do
    info = ["2012030221","3","away","LOSS","OT","John Tortorella","2","8","44","8","3","0","44.8","17","7"]
    game_team = GameTeam.new(info)
    expect(game_team.data).to be_a(Hash)
    expect(game_team.data.length).to eq(15)
  end

  it 'game_team has data' do
    info = ["2012030221","3","away","LOSS","OT","John Tortorella","2","8","44","8","3","0","44.8","17","7"]
    game_team = GameTeam.new(info)
    expect(game_team.data[:game_id]).to eq(2012030221)
    expect(game_team.data[:hoa]).to eq("away")
    expect(game_team.data[:tackles]).to eq(44)
    expect(game_team.data[:faceoff_win_percentage]).to eq(44.8)
  end
end
