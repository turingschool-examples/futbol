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

  it 'can return highest score' do
    dataset = GameData.new
    dataset.add_games
    expect(dataset.highest_total_score).to eq(11)
  end

  it 'can return lowest score' do
    dataset = GameData.new
    dataset.add_games
    expect(dataset.lowest_total_score).to eq(0)
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

  it 'returns average goals per game' do
    dataset = GameData.new
    dataset.add_games
    expect(dataset.average_goals_per_game).to eq(4.22)
  end

  it 'returns total goals by season' do
    dataset = GameData.new
    dataset.add_games
    expect(dataset.goals_per_season).to eq({"20122013"=>3322, 
                                            "20162017"=>5565, 
                                            "20142015"=>5461, 
                                            "20152016"=>5499, 
                                            "20132014"=>5547, 
                                            "20172018"=>6019})
  end
  
  it 'returns total games by season' do
    dataset = GameData.new
    dataset.add_games
    expect(dataset.games_per_season).to eq({"20122013"=>806, 
                                            "20162017"=>1317, 
                                            "20142015"=>1319, 
                                            "20152016"=>1321, 
                                            "20132014"=>1323, 
                                            "20172018"=>1355})
  end

  it 'returns average games per season' do
    dataset = GameData.new
    dataset.add_games
    expect(dataset.average_goals_by_season).to eq({ "20122013" => 4.12,
                                                    "20132014" => 4.19,
                                                    "20142015" => 4.14,
                                                    "20152016" => 4.16,
                                                    "20162017" => 4.23,
                                                    "20172018" => 4.44,})
  end
end