RSpec.describe Team do
  let(:team_data) {
    { team_id: "1",
      teamname: "Atlanta United",
      abbreviation: "ATL",
      stadium: "Mercedes-Benz Stadium"
    }}

  let(:team) { Team.new(team_data) }

  describe '#initialize' do
    it 'can initialize' do
      expect(team).to be_a(Team)
      expect(team.team_id).to eq(1)
      expect(team.teamname).to eq("Atlanta United")
      expect(team.abbreviation).to eq("ATL")
      expect(team.stadium).to eq("Mercedes-Benz Stadium")
    end
  end
end
