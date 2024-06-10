require 'spec_helper'
require './lib/team/'

RSpec.describe Team do
    before :all do
        @team_hash = {
            team_id: '29',
            franchiseid: '36',
            teamname: 'Orlando Pride',
            abbreviation: 'FLP',
            stadium: 'Exploria Stadium',
            link: '/api/v1/teams/29'
        }
        @team = Team.new(@team_hash)
    end

    it 'exists' do
        expect(@team).to be_a Team
    end
    
    it 'initializes with attributes' do
        expect(@team.team_id).to eq('29')
        expect(@team.franchiseId).to eq('36')
        expect(@team.teamName).to eq('Orlando Pride')
        expect(@team.abbreviation).to eq('FLP')
        expect(@team.Stadium).to eq('Exploria Stadium')
        expect(@team.link).to eq('/api/v1/teams/29')
    end
end