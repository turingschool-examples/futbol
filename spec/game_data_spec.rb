require 'spec_helper'

describe GameData do
  it 'can import game data' do
  dataset = GameData.new
  dataset.add_games
  
  expect(dataset.games[0].id).to eq("2012030221")
  end
end