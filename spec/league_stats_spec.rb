require 'rspec'
require './lib/league_stats.rb'

describe LeagueStats do 
	let(:league) {LeagueStats.new('./data/game_teams_sample.csv', './data/game_sample.csv')}

	it 'exists' do
			expect(league).to be_an_instance_of(LeagueStats)
	end

	it '#count of teams' do
		expect(league.count_of_teams).to eq(30)
	end

	it '#best offense' do 
		expect(league.best_offense).to eq("")
	end
end