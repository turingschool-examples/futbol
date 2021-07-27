require './lib/team'

RSpec.describe Team do

  it 'exists' do
    info = ["1","23","Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1"]
    team = Team.new(info)
    expect(team).to be_a(Team)
  end

  it 'data is a hash' do
    info = ["1","23","Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1"]
    team = Team.new(info)
    expect(team.data).to be_a(Hash)
    expect(team.data.length).to eq(6)
  end

  it 'game has data' do
    info = ["1","23","Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1"]
    team = Team.new(info)
    expect(team.data[:team_id]).to eq(1)
    expect(team.data[:team_name]).to eq("Atlanta United")
    expect(team.data[:stadium]).to eq("Mercedes-Benz Stadium")
  end
end
