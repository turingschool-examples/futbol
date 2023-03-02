require 'spec_helper'

RSpec.describe Team do
  let(:team_1) { Team.new(DATA[:teams][0]) }
  let(:team_2) { Team.new(DATA[:teams][1]) }

  describe '#initialize' do
    it 'exists' do
      expect(team_1).to be_a(Team)
      expect(team_2).to be_a(Team)
    end
  end

  describe '#id' do
    it 'has an id' do
      expect(team_1.id).to eq('1')
      expect(team_2.id).to eq('4')
    end
  end

  describe '#franchise_id' do
    it 'has a franchise_id' do
      expect(team_1.franchise_id).to eq('23')
      expect(team_2.franchise_id).to eq('16')
    end
  end

  describe '#name' do
    it 'has a name' do
      expect(team_1.name).to eq('Atlanta United')
      expect(team_2.name).to eq('Chicago Fire')
    end
  end

  describe '#abbreviation' do
    it 'has an abbreviation' do
      expect(team_1.abbreviation).to eq('ATL')
      expect(team_2.abbreviation).to eq('CHI')
    end
  end

  describe '#stadium' do
    it 'has a stadium' do
      expect(team_1.stadium).to eq('Mercedes-Benz Stadium')
      expect(team_2.stadium).to eq('SeatGeek Stadium')
    end
  end

  describe '#link' do
    it 'has a link' do
      expect(team_1.link).to eq('/api/v1/teams/1')
      expect(team_2.link).to eq('/api/v1/teams/4')
    end
  end
end
