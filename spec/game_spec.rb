require 'csv'
require './lib/game.rb'

RSpec.describe Game do

  game_file = CSV.read('./data/games_sample.csv', headers: true, header_converters: :symbol)
  game_array = game_file.map do |row|
    Game.new(row)
  end

  before(:each) do 
    @game = game_array
  end
  
  it 'exists' do 
    expect(@game).to be_an(Array)
    expect(@game.sample).to be_an_instance_of(Game)
  end

  it 'has attributes' do 
    expect(@game.first.game_id).to eq("2012030221")
  end
end
