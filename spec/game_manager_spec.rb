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
  end

  it "calculates highest total score" do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)
    expect(game_manager.highest_total_score).to eq(11)
  end
  it "caluculates lowest total score" do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)
    expect(game_manager.lowest_total_score).to eq(0)
  end

  it "calculates percentage of home wins" do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)
    expect(game_manager.percentage_home_wins).to eq(0.44)
  end

  it "calculates percentage of away wins" do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)
    expect(game_manager.percentage_visitor_wins).to eq(0.36)
  end

  it "calculates percentage of ties" do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)
    expect(game_manager.percentage_ties).to eq(0.2)
  end

  it 'counts games by season' do
    game_path = './data/games.csv'
    game_manager = GameManager.new(game_path)
    expect(game_manager.count_of_games_by_season).to eq( {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    })
  end
end
