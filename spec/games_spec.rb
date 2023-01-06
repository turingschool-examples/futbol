require './spec/spec_helper'

describe Game do
	before do
		game_path = './data/games_sample.csv'
		@games = Game.create_games(game_path)
		@game = @games[0]
	end

	describe '#initialize' do
		it 'exists' do
			expect(@games).to include(Game)
		end

		it 'has attributes' do
			expect(@game.game_id).to eq("2012030221")
		end
	end
end