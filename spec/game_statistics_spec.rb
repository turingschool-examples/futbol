require './lib/game_statistics'
require './lib/games'

xdescribe GameStats do
	before do
		game_path = './data/games_sample.csv'
		@games = Game.create_games(game_path)
	end

	let(:game) {@games[0]}
	let(:stat) {GameStats.new(@games)}

	describe '' do
		it '' do
			expect(stat.games_by_season(20132014)).to be_a('')
		end
	end
end