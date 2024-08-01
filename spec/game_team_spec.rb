require 'spec_helper'

RSpec.describe GameTeam do
    before(:each) do
        @game_teams_path = './data/game_teams.csv'
        @stat_tracker = StatTracker.from_csv(@game_teams_path)
        @game_team = GameTeam.new(@game_teams_path, @stat_tracker)
    end

    describe '#initialize' do
        it 'can initialize' do
            expect(@game_team).to be_an_instance_of(GameTeam)
        end

        it 'has a game_id, team_id, and hoa' do
            expect(@game_team.game_id).to eq(2012030221)
            expect(@game_team.team_id).to eq(3)
            expect(@game_team.hoa).to eq("away")
        end

        it 'has results, settled_in, and a head_coach' do
            expect(@game_team.results).to eq("LOSS")
            expect(@game_team.settled_in).to eq("OT")
            expect(@game_team.head_coach).to eq("John Tortorella")
        end

        it 'has goals, shots, and tackles' do
            expect(@game_team.goals).to eq(6)
            expect(@game_team.shots).to eq(8)
            expect(@game_team.tackles).to eq(44)
        end

        it 'has pim, power_play_opportunities, and power_play_goals' do
            expect(@game_team.pim).to eq(8)
            expect(@game_team.power_play_opportunities).to eq(3)
            expect(@game_team.power_play_goals).to eq(0)
        end

        it 'has face_off_win_percentage, giveaways, takeaways, and tracker' do
            expect(@game_team.face_off_win_percentage).to eq(44.8)
            expect(@game_team.giveaways).to eq(17)
            expect(@game_team.takeaways).to eq(7)
            expect(@game_team.tracker).to eq()
        end
    end
end