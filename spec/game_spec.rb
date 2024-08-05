require 'spec_helper'

RSpec.describe Game do
    before(:each) do
        CSV.foreach('./data/games_dummy.csv', headers: true, header_converters: :symbol) do |row|
            @game_1= Game.new(row) 
            break
        end
    end

    describe 'Initialize' do
        it 'exists' do
            expect(@game_1).to be_an_instance_of(Game)
        end

        it 'has game_id attribute' do
            expect(@game_1.game_id).to eq(2012030221)
        end

        it 'has season attribute' do
            expect(@game_1.season).to eq(20122013)
        end

        it 'has type attribute' do
            expect(@game_1.type).to eq('Postseason')
        end

        it 'has date_time attribute' do
            expect(@game_1.date_time).to eq('5/16/13')
        end

        it 'has away_team_id attribute' do
            expect(@game_1.away_team_id).to eq(3)
        end

        it 'has home_team_id attribute' do
            expect(@game_1.home_team_id).to eq(6)
        end

        it 'has away_goals attribute' do
            expect(@game_1.away_goals).to eq(2)
        end

        it 'has home_goals attribute' do
            expect(@game_1.home_goals).to eq(3)
        end

        it 'has venue attribute' do
            expect(@game_1.venue).to eq('Toyota Stadium')
        end
    end

    describe 'total_goals' do
        it 'returns sum of away_goals and home_goals' do
            expected = @game_1.away_goals + @game_1.home_goals
            expect(@game_1.total_goals).to eq(expected)
        end
    end
    
end