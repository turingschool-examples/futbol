require 'spec_helper'


RSpec.describe Season do
    before(:each) do
        CSV.foreach('./data/game_teams_dummy.csv', headers: true, header_converters: :symbol) do |row|
            @season_1 = Season.new(row)
            break
        end
    end

    describe 'Initialize' do
        it 'exists' do
            expect(@season_1).to be_an_instance_of(Season)
        end

        it 'has game_id attribute' do
            expect(@season_1.game_id).to eq(2012030221)
        end

        it 'has team_id attribute' do
            expect(@season_1.team_id).to eq(3)
        end

        it 'has hoa attribute' do
            expect(@season_1.hoa).to eq('away')
        end

        it 'has result attribute' do
            expect(@season_1.result).to eq('LOSS')
        end

        it 'has settled_in attribute' do
            expect(@season_1.settled_in).to eq('OT')
        end

        it 'has head_coach attribute' do
            expect(@season_1.head_coach).to eq('John Tortorella')
        end

        it 'has goals attribute' do
            expect(@season_1.goals).to eq(2)
        end

        it 'has shots attribute' do
            expect(@season_1.shots).to eq(8)
        end

        it 'has tackles attribute' do
            expect(@season_1.tackles).to eq(44)
        end

        it 'has pim attribute' do
            expect(@season_1.pim).to eq(8)
        end

        it 'has power_play_opportunities attribute' do
            expect(@season_1.power_play_opportunities).to eq(3)
        end

        it 'has power_play_goals attribute' do
            expect(@season_1.power_play_goals).to eq(0)
        end

        it 'has face_off_win_percentage attribute' do
            expect(@season_1.face_off_win_percentage).to eq(44)
        end

        it 'has giveaways attribute' do
            expect(@season_1.giveaways).to eq(17)
        end

        it 'has takeaways attribute' do
            expect(@season_1.takeaways).to eq(7)
        end
    end
end
