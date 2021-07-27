require './lib/team'

RSpec.describe Team do

  it 'exists' do
    info = ["1","23","Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1"]
    team = Team.new(info)
    expect(team).to be_a(Team)
  end

  it 'game has data' do
    info = ["1","23","Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1"]
    team = Team.new(info)
    expect(team.team_id).to eq(1)
    expect(team.team_name).to eq("Atlanta United")
    expect(team.stadium).to eq("Mercedes-Benz Stadium")
  end
end
