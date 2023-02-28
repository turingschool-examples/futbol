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
    expect(highest_total_score).to eq(11)
  end

  it 'can return lowest score' do
    expect(lowest_total_score).to eq(0)
  end
end