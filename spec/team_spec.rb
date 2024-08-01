require 'spec_helper'

RSpec.describe Team do
    before(:each) do
        CSV.foreach('./data/teams_dummy.csv', headers: true, header_converters: :symbol) do |row|
            @team_1 = Team.new(row)
            break
        end
    end

    describe 'Initialize' do
        it 'exists' do
            expect(@team_1).to be_an_instance_of(Team)
        end

        it 'has team_id attribute' do
            expect(@team_1.team_id).to eq(1)
        end

        it 'has franchise_id attribute' do
            expect(@team_1.franchise_id).to eq(23)
        end

        it 'has team_name attribute' do
            expect(@team_1.team_name).to eq('Atlanta United')
        end

        it 'has abbreviation attribute' do
            expect(@team_1.abbreviation).to eq('ATL')
        end

        it 'has stadium attribute' do
            expect(@team_1.stadium).to eq('Mercedes-Benz Stadium')
        end
    end
end
