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
    @game_teams_data = tracker.game_teams_data.first
  end

    describe 'initialize' do
        it 'exists' do
            expect(@game_teams_data).to be_an_instance_of(GameTeam)
        end

        it 'has attributes' do
            expect(@game_teams_data.game_id).to eq("2012030221")
            expect(@game_teams_data.team_id).to eq("3")
            expect(@game_teams_data.hoa).to eq("away")
            expect(@game_teams_data.result).to eq("LOSS")
            expect(@game_teams_data.settled_in).to eq("OT")
            expect(@game_teams_data.head_coach).to eq("John Tortorella")
            expect(@game_teams_data.goals).to eq("2")
            expect(@game_teams_data.shots).to eq("8")
            expect(@game_teams_data.tackles).to eq("44")
            expect(@game_teams_data.pim).to eq("8")
            expect(@game_teams_data.power_play_opportunities).to eq("3")
            expect(@game_teams_data.power_play_goals).to eq("0")
            expect(@game_teams_data.face_off_win_percentage).to eq("44.8")
            expect(@game_teams_data.giveaways).to eq("17")
            expect(@game_teams_data.takeaways).to eq("7")
        end
    end
end