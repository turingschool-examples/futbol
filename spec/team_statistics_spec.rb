require_relative './spec_helper'
require_relative '../lib/team_statistics'

RSpec.describe TeamSatistics do
    before(:all) do
        
    end
    describe ".team_satistics instantiation" do
        context "object exists as an instantiation of class" do
            it 'is instance of class' do
                expect(@team_satistics).to be_an_instance_of(TeamSatistics)
            end
        end
    end
    describe ".team_info" do
        context "team_info returns a hash" do
            xit 'returns a hash' do
                expect(team_statistics.team_info("24")).to be_in(Hash)
            end
            xit 'returns team_id, franchise_id, team_name, abbreviation, and link' do
                expect(team_statistics.team_info("24")).to eq({team_id: 24, franchise_id: 32, team_name: "Real Salt Lake", abbreviation: :RSL, link: "/api/v1/teams/24"})
            end
        end
    end
    describe ".best_season" do
        context "best_season returns a string" do
            xit 'returns a string' do
                expect(team_statistics.best_season("6")).to be_in(String)
            end
            xit 'returns highest win percentage' do
                expect(team_statistics.best_season("6").to eq("20132014"))
            end
        end
    end
    describe ".worst_season" do
        context "worst_season returns a string" do
            xit 'returns a string' do
                expect(team_statistics.worst_season("6")).to be_in(String)
            end
            xit 'returns highest win percentage' do
                expect(team_statistics.worst_season("6").to eq("20142015"))
            end
        end
    end
    describe ".average_win_percentage" do
        context "average_win_percentage returns a float" do
            xit 'returns a float' do
                expect(team_statistics.average_win_percentage("6")).to be_in(Float)
            end
            xit 'returns average win percentage' do
                expect(team_statistics.average_win_percentage("6")).to eq(0.49)
            end
        end
    end
end