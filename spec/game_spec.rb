require './spec/spec_helper'

RSpec.describe Game do
    before(:each) do 
      game_path = './data_mock/games.csv'
      team_path = './data_mock/teams.csv'
      game_teams_path = './data_mock/game_teams.csv'
      
      @locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }
      
      @team_data = {
        team_id: "1",
        franchiseId: "23",
        teamName: "Atlanta United",
        abbreviation: "ATL",
        Stadium: "Mercedes-Benz Stadium"
      }
      
      @stat_tracker = StatTracker.from_csv(@locations)
    end

      it "is created by stat_tracker" do
        expect(@stat_tracker.games).to be_a(Array)
        expect(@stat_tracker.games).to all(be_a(Game))
      end

end