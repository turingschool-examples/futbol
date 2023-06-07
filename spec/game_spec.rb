require './lib/game'
require "csv"


RSpec.describe 'Game' do
  it 'exisits' do
    game = Game.new
    expect(game).to be_a(Game)
  end

  it "can find the percentage of games that resulted in a tie" do
    game = Game.new

    expect(game.percentage_ties).to eq(0.20)
  end
end

