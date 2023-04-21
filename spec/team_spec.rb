require './lib/team'

RSpec.describe Team do
  before(:each) do
    @team = Team.new({
      team_id: "1",
      franchiseid: "23",
      teamname: "Atlanta United",
      stadium: "Mercedes-Benz Stadium"
    })
  end

  describe 'initialize' do
    it 'exists' do
    expect(@team).to be_a(Team)
    end

    it "has readable attributes" do
      expect(@team.team_id).to eq("1")
      expect(@team.franchiseid).to eq("23")
      expect(@team.teamname).to eq("Atlanta United")
      expect(@team.stadium).to eq("Mercedes-Benz Stadium")
    end
  end
end