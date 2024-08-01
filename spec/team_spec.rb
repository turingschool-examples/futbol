require 'spec_helper'

RSpec.describe Team do
    before(:each) do
        @team_path = './data/teams.csv'
        @stat_tracker = StatTracker.from_csv(@team_path)
        @team = Team.new(@teams_path, @stat_tracker)
    end

    describe '#initialize' do
        it 'can initialize' do
            expect(@team).to be_an_instance_of(Team)
        end

        it 'has a team_id, franchise_id, team_name, and abbreviation' do
            expect(@team.team_id).to eq(1)
            expect(@team.franchise_id).to eq(23)
            expect(@team.team_name).to eq("Atlanta United")
            expect(@team.abbreviation).to eq("ALT")
        end

        it 'has a stadium and a link' do
            expect(@team.stadium).to eq("Mercedes-Benz Stadium")
            expect(@team.link).to eq("/api/v1/teams/1")
        end
    end
end
