require 'rspec'
require './lib/gamestats'

describe GameStats do 
    let(:gamestats) {GameStats.new}

    it 'exists' do
        expect(gamestats).to be_an_instance_of(GameStats)
    end

    it 'attributes' do
        expect(gamestats.games).to eq(Array)
    end
end
