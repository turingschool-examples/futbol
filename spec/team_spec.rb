RSpec.describe Team do
  let(:team_data) {
    { team_id: "1",
      franchiseId: "23",
      teamName: "Atlanta United",
      abbreviation: "ATL",
      Stadium: "Mercedes-Benz Stadium"
    }}

  let(:team) { Team.new(team_data) }

  describe '#initialize' do
    it 'can initialize' do
      expect(team).to be_a(Team)
      expect(team.team_id).to eq("1")
      expect(team.franchiseId).to eq("23")
      expect(team.teamName).to eq("Atlanta United")
      expect(team.abbreviation).to eq("ATL")
      expect(team.Stadium).to eq("Mercedes-Benz Stadium")
    end
  end
end
