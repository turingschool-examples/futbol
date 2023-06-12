require 'spec_helper'


describe Team do
  describe '#initialize' do
    it 'exists' do
      info = {
        team_id: '4',
        franchiseId: '16',
        teamName: 'Chicago Fire',
        abbreviation: 'CHI',
        stadium: 'Toyota Stadium',
        link: '/api/v1/teams/4'
      }

      team = Team.new(info)

      expect(team).to be_a Team
    end

    it 'has attributes' do
      info = {
        team_id: '4',
        franchiseId: '16',
        teamName: 'Chicago Fire',
        abbreviation: 'CHI',
        stadium: 'Toyota Stadium',
        link: '/api/v1/teams/4'
      }

      team = Team.new(info)

      expect(team.team_id).to eq('4')
      expect(team.franchise_id).to eq('16')
      expect(team.team_name).to eq('Chicago Fire')
      expect(team.team_abbreviation).to eq('CHI')
      expect(team.team_stadium).to eq('Toyota Stadium')
      expect(team.team_link).to eq('/api/v1/teams/4')
    end
  end
end

team_path = './data/teams.csv'
describe Team do
end

