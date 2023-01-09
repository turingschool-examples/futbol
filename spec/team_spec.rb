require_relative 'spec_helper'

RSpec.describe Team do

  info = {
      team_id: "1",
      franchiseid: "23", 
      teamname: "Atlanta United", 
      abbreviation: "ATL", 
      stadium: "Mercedes-Benz Stadium", 
      link:"/api/v1/teams/1"
    }

  let(:team_row1){Team.new(info)}

  describe '#initialize' do
    it 'exists' do
      expect(team_row1).to be_a(Team)
    end

    it 'initializes with attributes' do
      expect(team_row1.team_id).to eq("1")
      expect(team_row1.franchise_id).to eq("23")
      expect(team_row1.team_name).to eq("Atlanta United")
      expect(team_row1.abbreviation).to eq("ATL")
      expect(team_row1.stadium).to eq("Mercedes-Benz Stadium")
      expect(team_row1.link).to eq("/api/v1/teams/1")
    end
  end
end