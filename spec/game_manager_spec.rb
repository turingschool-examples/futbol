require 'CSV'
require './lib/stat_tracker'
require './lib/game_manager'

RSpec.describe GameManager do
  it 'exists' do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)

    expect(game_manager).to be_an_instance_of(GameManager)
  end

  it 'starts with no game objects' do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)

    expect(game_manager.game_objects).to eq([])
  end

  it 'can create game objects' do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)

    expect(game_manager.create_game_manager).to be_an(Array)
    # expect(game_manager.add_objects).to be_an_instance_of(GameManager)
    expect(game_manager.create_game_manager.count).to eq(7441)
  end
end
