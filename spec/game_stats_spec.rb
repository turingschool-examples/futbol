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
end
