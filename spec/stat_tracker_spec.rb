require_relative "spec_helper"

RSpec.describe StatTracker do
    before do 
        @game_path = './spec/fixtures/games.csv'
        @team_path = './spec/fixtures/teams.csv'
        @game_teams_path = './spec/fixtures/game_teams.csv'

        location_paths = {
            games: @game_path,
            teams: @team_path,
            game_teams: @game_teams_path
          }

        @stat_tracker = StatTracker.from_csv(location_paths)
    
    end
    
    it "exists" do
        expect(@stat_tracker).to be_instance_of(StatTracker)
    end
    
end