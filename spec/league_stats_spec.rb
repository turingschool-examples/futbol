require 'rspec'
require './lib/league_stats.rb'

describe League do 
    let(:league) {League.new}

    it 'exists' do
        expect(league).to be_an_instance_of(League)
    end

    it 'attributes' do
        expect(league.name).to eq()
    end
end