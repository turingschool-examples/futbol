require 'csv'
require './lib/game'

describe Game do
  before(:each) do
    game_path = './data/games_tester.csv'

    locations = {
      games: game_path
    }

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      @game = Game.new(row)
    end
  end

  it 'exists' do
    expect(@game).to be_instance_of(Game)
  end
  
end
