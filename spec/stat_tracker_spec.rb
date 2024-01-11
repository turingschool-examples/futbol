require 'spec_helper'

RSpec.describe StatTracker do
   before(:each) do
      game_path = './data/games_fixture.csv'
      team_path = './data/teams_fixture.csv'
      game_teams_path = './data/game_teams_fixture.csv'

      locations = {
         games: game_path,
         teams: team_path,
         game_teams: game_teams_path
      }

      @stat_tracker = StatTracker.from_csv(locations)
   end

   it 'exists' do
      expect(@stat_tracker).to be_a StatTracker
   end

   describe '#read_games_csv' do
      it 'create game objects' do
         location = './data/games_fixture.csv'

         expect(@stat_tracker.read_games_csv(location)[0]).to be_a Game
      end
   end

   describe '#read_teams_csv' do
      it 'create teams objects' do
         location = './data/teams_fixture.csv'

         expect(@stat_tracker.read_teams_csv(location)[0]).to be_a Team
      end
   end

   describe '#read_game_teams_csv' do
      it 'create game_team objects' do
         location = './data/game_teams_fixture.csv'
         game_team_0 = @stat_tracker.read_game_teams_csv(location)[0]

         expect(@stat_tracker.read_game_teams_csv(location)[0]).to be_a GameTeam
         expect(game_team_0.game_id).to eq("2012030221")
         expect(game_team_0.team_id).to eq(3)
         expect(game_team_0.hoa).to eq("away")
         expect(game_team_0.result).to eq("LOSS")
         expect(game_team_0.head_coach).to eq("John Tortorella")
         expect(game_team_0.goals).to eq(2)
         expect(game_team_0.shots).to eq(8)
         expect(game_team_0.tackles).to eq(44)
      end
   end
end