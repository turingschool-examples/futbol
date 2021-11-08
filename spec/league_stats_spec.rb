require 'rspec'
require './lib/league_stats.rb'

describe LeagueStats do 
    let(:league) {LeagueStats.new('./data/game_teams_sample.csv')}

    it 'exists' do
        expect(league).to be_an_instance_of(LeagueStats)
    end

    xit 'attributes' do
        expect(league.name).to be_an(Array)
    end
end