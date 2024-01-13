require './lib/game_teams'
require './lib/game_teams_factory'
require 'pry'

RSpec.describe GameTeamFactory do
	before do
			@file_path = './data/game_teams_fixture.csv'
			@game_team_factory = GameTeamFactory.new(@file_path)
	end

	describe '#initialize' do
		it 'exists' do 
				expect(@game_team_factory).to be_a(GameTeamFactory)
		end

		it 'has a file path attribute' do
				expect(@game_team_factory.file_path).to eq(@file_path)
		end
	end
end