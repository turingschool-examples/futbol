require 'csv'
require './lib/stat_tracker'
require './lib/game_teams.rb'

RSpec.describe GameTeams do
    before(:each) do
        @game_teams_path = './data/game_teams.csv'
        # @stat_tracker = StatTracker.from_csv(@locations)
        @game_teams = GameTeams.new(@game_teams_path, tracker)
    end

    describe '#initialize' do
        it 'can initialize' do
            expect(@game_teams).to be_an_instance_of(GameTeams)
        end

        it 'has a game_id, team_id, and hoa' do
            expect(@game.game_id).to eq(2012030221)
            expect(@game.team_id).to eq(3)
            expect(@game.hoa).to eq("away")
        end

        it 'has results, settled_in, and a head_coach' do
            expect(@game.results).to eq("LOSS")
            expect(@game.settled_in).to eq("OT")
            expect(@game.head_coach).to eq("John Tortorella")
        end

        it 'has goals, shots, and tackles' do
            expect(@game.goals).to eq(6)
            expect(@game.shots).to eq(8)
            expect(@game.tackles).to eq(44)
        end

        it 'has pim, power_play_opportunities, and power_play_goals' do
            expect(@game.pim).to eq(8)
            expect(@game.power_play_opportunities).to eq(3)
            expect(@game.power_play_goals).to eq(0)
        end

        it 'has face_off_win_percentage, giveaways, takeaways, and tracker' do
            expect(@game.face_off_win_percentage).to eq(44.8)
            expect(@game.giveaways).to eq(17)
            expect(@game.takeaways).to eq(7)
            expect(@game.tracker).to eq()
        end
    end
end