require 'spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe Team do
    before(:each) do
        team_path = './data/teams.csv'

        @teams_data = {
            :team_id => "1",
            :franchiseid => "23",
            :teamname => "Atlanta United",
            :abbreviation => "ATL",
        }

        @team = Team.new(@teams_data)
    end

    it 'exists' do 
        expect(@team).to be_a Team
    end

    it 'contains team data' do
        expect(@team.team_id).to eq("1")
        expect(@team.franchise_id).to eq("23")
        expect(@team.team_name).to eq("Atlanta United")
        expect(@team.abbreviation).to eq("ATL")
    end
end