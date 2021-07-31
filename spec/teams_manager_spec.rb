require 'spec_helper'

RSpec.describe TeamsManager do
  context 'teams_manager' do

    teams_manager = TeamsManager.new('./data/teams.csv')

    it "has attributes" do
      expect(teams_manager.teams).not_to be_empty
    end

    it 'makes teams' do
      expect(teams_manager).to respond_to(:make_teams)
    end

    it 'has team info' do
      expected = {
        "team_id" => "18",
        "franchise_id" => "34",
        "team_name" => "Minnesota United FC",
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
      }

      expect(teams_manager.team_info("18")).to eq(expected)
    end

    it 'has a teams count in a league' do
      expect(teams_manager.count_of_teams).to eq(32)
    end

    it 'returns team name by team id' do
      expect(teams_manager.team_by_id("18")).to eq("Minnesota United FC")
    end

  end
end
