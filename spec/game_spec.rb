require './lib/game'
require './lib/game_tracker'
require 'pry'

RSpec.describe do Game
  it 'exists' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker).to be_an_instance_of(GameTracker)
  end


  it 'give highest total score' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker.highest_total_score).to be(5)
  end

  it 'give lowest total score' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker.lowest_total_score).to be(1)
  end

  it 'percentage_home_wins' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker.percentage_home_wins).to be(68.18)
  end

  it 'percentage_visitor_wins' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker.percentage_vistor_wins).to be(27.27)
  end

  it 'percentage_ties' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker.percentage_ties).to be(4.55)
  end

  it 'count_of_games_by_season' do
    game_path = './data/games_stub_2.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker.count_of_games_by_season).to eq({'20122013' => 57, '20162017' => 4, '20142015' => 6})
  end

  it 'average_goals_per_game' do
    game_path = './data/games_stub.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker.average_goals_per_game).to eq(3.77)
  end

  it 'average_goals_by_season' do
    game_path = './data/average_goals_by_season.csv'
    locations = {games: game_path}
    gametracker = GameTracker.new(game_path)
    expect(gametracker.average_goals_by_season).to eq({'20122013' => 4.5, '20162017' => 4.75, '20142015' => 4})
  end



end
