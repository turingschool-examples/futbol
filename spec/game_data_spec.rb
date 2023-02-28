require 'spec_helper'

describe GameData do
  it 'can import game data' do
  dataset = GameData.new
  dataset.add_games
  
  expect(dataset.games[0].id).to eq("2012030221")
  end

  it 'can list wins_losses' do
  dataset = GameData.new
  dataset.add_games
  dataset.wins_losses

  expect(dataset.total_games).to eq(7441)
  expect(dataset.percentage_home_wins).to eq(0.44)
  expect(dataset.percentage_visitor_wins).to eq(0.36)
  expect(dataset.percentage_ties).to eq(0.2)
  end

  it 'returns a count of games by season' do
    dataset = GameData.new
    dataset.add_games
    expect(dataset.count_of_games_by_season).to eq({"20122013"=>806, 
                                                    "20162017"=>1317, 
                                                    "20142015"=>1319, 
                                                    "20152016"=>1321, 
                                                    "20132014"=>1323, 
                                                    "20172018"=>1355})
  end
end