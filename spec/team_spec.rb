require './lib/team'

RSpec.describe Team do
  before(:each) do
    @team = Team.new("1", "23", "Atlanta United", "Mercedes-Benz Stadium")
  end

  describe 'initialize' do
    it 'exists' do
    expect(@team).to be_a(Team)
    end

    it "has readable attributes" do
      expect(@team.team_id).to eq("1")
    end

  end
end