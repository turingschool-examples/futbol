require './lib/game'

RSpec.describe do Game
  it 'exists' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
     game = Game.new(locations[:games])
     expect(game).to be_an_instance_of(Game)
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
  # it '' do
  #
  # end
end
