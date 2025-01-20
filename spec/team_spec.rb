require './spec/spec_helper'

describe Team do
  before(:each) do
    @team = Team.new(1, 23, "Atlanta United", "ATL", "Mercedes-Benz Stadium", "/api/v1/teams/1")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@team).to be_a(Team)
    end

    it 'has a team id' do
      expect(@team.team_id).to eq(1)
    end

    it 'has a franchise id' do
      expect(@team.franchise_id).to eq(23)
    end

    it 'has a team name' do
      expect(@team.team_name).to eq("Atlanta United")
    end

    it 'has an abbreviation' do
      expect(@team.abbreviation).to eq("ATL")
    end

    it 'has a stadium name' do
      expect(@team.stadium).to eq("Mercedes-Benz Stadium")
    end

    it 'has a link' do
      expect(@team.link).to eq("/api/v1/teams/1")
    end
  end
end