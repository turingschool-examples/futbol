require 'spec_helper'

RSpec.describe GameStatistics do
    before(:each) do
        game_path = './data/games_dummy.csv'

        @game_stats = GameStatistics.new(StatTracker.game_reader(game_path))
    end
    describe 'Initialize' do
        it 'exists' do
            expect(@game_stats).to be_an_instance_of(GameStatistics)
        end
    end

    describe 'highest_total_score' do
        it 'returns highest sum of the winning and losing teams scores' do
            expect(@game_stats.highest_total_score).to eq(5)
        end
    end
end