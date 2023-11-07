require 'CSV'
require './spec/spec_helper'
req

teams = []

CSV.foreach('./data/teams.csv', headers: true, header_converters: :symbol) do |row|
    team_id = row[:team_id].to_i
    franchise_id = row[:franchiseid].to_i
    team_name = row[:teamname].to_s
    abbreviation = row[:abbreviation].to_s
    stadium = row[:stadium].to_s
    link = row[:link].to_s

    new_team = Team.new(team_id,franchise_id,team_name,abbreviation,stadium,link)

    teams.append(new_team)
end

RSpec.describe Team do
    it "can correctly create new Team class instance" do
        team1 = teams.find { |team| team.team_id == 1}

        expect(team1.team_id).to eq(1)
        expect(team1.franchise_id).to eq(23)
        expect(team1.team_name).to eq("Atlanta United")
        expect(team1.abbreviation).to eq("ATL")
        expect(team1.stadium).to eq("Mercedes-Benz Stadium")
        expect(team1.link).to eq("/api/v1/teams/1")
    end
end