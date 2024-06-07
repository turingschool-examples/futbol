require 'spec_helper'

RSpec.describe Team do
  before(:each) do
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    tracker = StatTracker.from_csv(locations)
    @team_data = tracker.team_data.first  
  end

    describe 'initialize' do
        it 'exists' do
            expect(@team_data).to be_an_instance_of(Team)
        end

        it 'has attributes' do
            expect(@team_data.team_id).to eq("1")
            expect(@team_data.franchise_id).to eq("23")
            expect(@team_data.team_name).to eq("Atlanta United")
            expect(@team_data.abbreviation).to eq("ATL")
            expect(@team_data.stadium).to eq("Mercedes-Benz Stadium")
            expect(@team_data.link).to eq("/api/v1/teams/1")
        end
    end
end