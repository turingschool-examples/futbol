require 'CSV'
require './lib/team'
require './lib/teams'

RSpec.describe Teams do
    it "can correctly create new Teams class instance" do
        teams = Teams.new

        expect(teams.array.length).to eq(32)

        team1 = teams.array.find { |team| team.team_id == 1}

        expect(team1.team_id).to eq(1)
        expect(team1.franchise_id).to eq(23)
        expect(team1.team_name).to eq("Atlanta United")
        expect(team1.abbreviation).to eq("ATL")
        expect(team1.stadium).to eq("Mercedes-Benz Stadium")
        expect(team1.link).to eq("/api/v1/teams/1")
    end
end