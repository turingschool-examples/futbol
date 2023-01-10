require 'spec_helper'

RSpec.describe Game do
	before do
    location = './data/games.csv'
		@games = Game.all_games(location)
	end
    let(:game){@games[0]}

    describe "#initialize" do
      it 'exists' do
        expect(game).to be_a(Game)
      end

      it 'can read attributes' do
        expect(game.type).to eq("Postseason")
      end
    end
end