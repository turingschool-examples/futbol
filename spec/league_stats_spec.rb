require 'rspec'
require './lib/league_stats.rb'

describe LeagueStats do 
	let(:league) {LeagueStats.new('./data/game_teams_sample.csv', './data/teams.csv', './data/games_sample.csv')}

	it 'exists' do
			expect(league).to be_an_instance_of(LeagueStats)
	end

	it '#count of teams' do
		expect(league.count_of_teams).to eq(94)
	end

	it '#total goals' do 
		expect(league.total_goals("3")).to eq(29)
	end

	it 'total games' do 
		expect(league.total_games("3")).to eq(16)
	end

	it 'find_team_name' do 
		expect(league.find_team_name("3")).to eq("Houston Dynamo")
	end

	it '#best offense' do 
		expect(league.best_offense).to eq("Reign FC")
	end

	it '#worst offense' do 
		expect(league.worst_offense).to eq("LA Galaxy")
	end

	it 'away teams list' do 
		expect(league.away_teams_list).to be_an(Array)
		expect(league.away_teams_list.count).to eq(47)
	end

	it 'home teams list' do 
		expect(league.home_teams_list).to be_an(Array)
		expect(league.home_teams_list.count).to eq(47)
	end

	it '#highest_scoring_visitor' do 
		expect(league.highest_scoring_visitor).to eq("FC Dallas")
	end
	
	it '#lowest_scoring_visitor' do 
		expect(league.lowest_scoring_visitor).to eq("Sporting Kansas City")
	end

	it '#highest scoring home team' do 
		expect(league.highest_scoring_home_team).to eq("New England Revolution")
	end

	it '#lowest scoring home team' do 
		expect(league.lowest_scoring_home_team).to eq("Portland Timbers")
	end
end