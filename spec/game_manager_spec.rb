require 'CSV'
require './lib/stat_tracker'
require './lib/game_manager'

RSpec.describe GameManager do
  it 'exists' do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)

    expect(game_manager).to be_an_instance_of(GameManager)
  end

  xit 'starts with no game objects' do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)

    expect(game_manager.game_objects).to eq([])
  end

  it 'can create game objects' do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)

    expect(game_manager.game_objects[0]).to be_an(Games)
    # expect(game_manager.add_objects).to be_an_instance_of(GameManager)
    expect(game_manager.game_objects.count).to eq(7441)
    expect(game_manager.highest_total_score).to eq(0)
  end
end
