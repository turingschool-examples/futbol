require 'csv'
require './lib/game.rb'

RSpec.describe Game do

  game_file = CSV.read('./data/games_sample.csv', headers: true, header_converters: :symbol)
  game_array = game_file.map do |row|
    Game.new(row)
  end

  before(:each) do 
    @game = game_array
  end
  
  it 'exists' do 
    expect(@game).to be_an(Array)
    expect(@game.sample).to be_an_instance_of(Game)
  end

  it 'has attributes' do 
    expect(@game.first.away_goals).to eq("2")
    expect(@game.first.away_team_id).to eq("6")
    expect(@game.first.date_time).to eq("5/16/13")
    expect(@game.first.game_id).to eq("2012030221")
    expect(@game.first.home_goals).to eq("3")
    expect(@game.first.season).to eq("20122013")
    expect(@game.first.type).to eq("Postseason")
    expect(@game.first.venue).to eq("Toyota Stadium")
    expect(@game.first.venue_link).to eq("/api/v1/venues/null")
  end
end
