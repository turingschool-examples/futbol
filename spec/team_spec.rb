require_relative 'spec_helper'

RSpec.describe Team do
  teams = CSV.read './data/teams.csv', headers: true, header_converters: :symbol

  let(:team_row1){Team.new(teams[0]) }

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