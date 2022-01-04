require './lib/game'

RSpec.describe do Game
  it 'exists' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
     game = Game.new(locations[:games])
     expect(game).to be_an_instance_of(Game)
  end


  it 'will give results' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    game = Game.new(locations[:games])
    expect(game.highest_total_score).to be(5)

  end
  # it '' do
  #
  # end
  # it '' do
  #
  # end
  # it '' do
  #
  # end
end
