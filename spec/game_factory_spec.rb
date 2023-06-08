require './lib/game_factory'

RSpec.describe GameFactory do
  it 'exists' do

    expect(GameFactory.new).to be_a(GameFactory)
  end

  it "can find the percertage of games that are ties" do
    game_factory = GameFactory.new
    game_factory.create_games('./data/games.csv')

    expect(game_factory.percent_of_ties).to eq(0.20)
  end

end
