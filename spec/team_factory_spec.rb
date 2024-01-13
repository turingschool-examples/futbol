require 'spec_helper'

RSpec.describe TeamFactory do
    before do
        
        @file_path = './data/teams_fixture.csv'
        @team_factory = TeamFactory.new(@file_path)
        
    end
    
    describe '#initialize' do

        it 'exists' do

            expect(@team_factory).to be_a(TeamFactory)

        end

        it 'has a file path attribute' do

            expect(@team_factory.file_path).to eq(@file_path)

        end
    end

    describe '#create_teams' do
        it 'creates team objects from the data stored in its file_path attribute' do

            expect(@team_factory.create_teams).to be_a(Array)
            expect(@team_factory.create_teams.all? {|team| team.class == Team}).to eq(true)

        end

        it 'creates objects with the necessary attributes' do

            expect(@team_factory.create_teams.first.team_id).to eq(1)
            expect(@team_factory.create_teams.first.franchise_id).to eq(23)
            expect(@team_factory.create_teams.first.team_name).to eq("Atlanta United")
            expect(@team_factory.create_teams.first.abbreviation).to eq("ATL")
            expect(@team_factory.create_teams.first.stadium).to eq("Mercedes-Benz Stadium")
            expect(@team_factory.create_teams.first.link).to eq("/api/v1/teams/1")
            
        end
    end
end

