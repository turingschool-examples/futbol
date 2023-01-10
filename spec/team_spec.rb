require "./spec_helper"

RSpec.describe Team do
    before do
        info = {
        team_id: "1",
        franchiseID: "23",
        teamName: "Atlanta United",
        abbreviation: "ATL",
        Stadium: "Mercedes_Benz Stadium",
        link: "api/v1/teams/1"
        }
        @team = Team.new(info)
    end

    describe "#initialize" do
        it "exists" do
            expect(@team).to be_instance_of Team
        end
        
        it "has attributes" do
            expect(@team.team_id).to eq("1")
            expect(@team.franchise_id).to eq("23")
            expect(@team.team_name).to eq("Atlanta United")
            expect(@team.abbreviation).to eq("ATL")
            expect(@team.stadium).to eq("Mercedes_Benz Stadium")
            expect(@team.link).to eq("api/v1/teams/1")
        end
    end
end