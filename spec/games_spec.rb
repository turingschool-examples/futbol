require './spec/spec_helper'

describe Game do
	before do
		game_path = './data/games_sample.csv'
		@games = Game.create_games(game_path)
	end
	let(:game) {@games[0]}

	describe '#initialize' do
		it 'exists' do
			expect(game).to be_a(Game)
		end

		it 'has attributes' do
			expect(game.info[:game_id]).to eq(2012030221)
			expect(game.info[:season]).to eq(20122013)
			expect(game.info[:type]).to eq("Postseason")
			expect(game.info[:date_time]).to eq("5/16/13")
			expect(game.info[:away_team_id]).to eq(3)
			expect(game.info[:home_team_id]).to eq(6)
			expect(game.info[:away_goals]).to eq(2)
			expect(game.info[:home_goals]).to eq(3)
			expect(game.info[:venue]).to eq("Toyota Stadium")
			expect(game.info[:venue_link]).to eq("/api/v1/venues/null")
		end
	end
end