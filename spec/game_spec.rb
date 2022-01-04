require './lib/game'

RSpec.describe do Game
  it 'exists' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    game = Game.new(locations[:games])
     expect(game).to be_an_instance_of(Game)
  end


  it 'give highest total score' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    game = Game.new(locations[:games])
    expect(game.highest_total_score).to be(5)
  end

  it 'give lowest total score' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    game = Game.new(locations[:games])
    expect(game.lowest_total_score).to be(1)
  end

  it 'percentage_home_wins' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    game = Game.new(locations[:games])
    expect(game.percentage_home_wins).to be(68.18)
  end

  it 'percentage_visitor_wins' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    game = Game.new(locations[:games])
    expect(game.percentage_vistor_wins).to be(27.27)
  end


end
