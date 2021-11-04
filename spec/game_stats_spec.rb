require 'rspec'
require './lib/game_stats'

describe GameStats do

    let(:gamestats) {GameStats.new('./data/games_sample.csv')}
    it 'exists' do
        expect(gamestats).to be_an_instance_of(GameStats)
    end

    it 'attributes' do
        expect(gamestats.games).to be_an(Array)
    end

    it "can show you the highest total score of all games" do
        expect(gamestats.highest_total_score).to eq(5)
    end

    it "can show you the lowest total score of all games" do
        expect(gamestats.lowest_total_score).to eq(1)

    end
end
