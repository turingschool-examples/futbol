require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Teams do
  describe '#initialize' do
    it "exists with attributes" do
      team = Teams.new(1, 23, "Atlanta United", "ATL", "Mercedes-Benz Stadium", "/api/v1/teams/1")
      
      expect(team).to be_a Teams
      expect(team.team_id).to be 1
      expect(team.franchise_id).to be 23
      expect(team.team_name).to eq("Atlanta United")
      expect(team.abbreviation).to eq("ATL")
      expect(team.stadium).to eq("Mercedes-Benz Stadium")
      expect(team.link).to eq("/api/v1/teams/1")
    end

    it 'can create data objects from csv file' do
      path = "./data/teams.csv"
      teams = Teams.create_teams_data_objects(path)

      expect(teams.count).to be 32
      expect(teams).to be_all Teams

      expect(teams.first).to be_a Teams
      expect(teams.first.team_id).to be 1
      expect(teams.first.franchise_id).to be 23
      expect(teams.first.team_name).to eq("Atlanta United")
      expect(teams.first.abbreviation).to eq("ATL")
      expect(teams.first.stadium).to eq("Mercedes-Benz Stadium")
      expect(teams.first.link).to eq("/api/v1/teams/1")
    end
  end

end