require './lib/game.rb'

RSpec.describe Game do

  it 'exists' do
    info = ["2012030221","20122013","Postseason","5/16/13","3","6","2","3","Toyota Stadium","/api/v1/venues/null"]
    game = Game.new(info)
    expect(game).to be_a(Game)
  end

  it 'data is a hash' do
    info = ["2012030221","20122013","Postseason","5/16/13","3","6","2","3","Toyota Stadium","/api/v1/venues/null"]
    game = Game.new(info)
    expect(game.data).to be_a(Hash)
  end

  it 'game has data' do
    info = ["2012030221","20122013","Postseason","5/16/13","3","6","2","3","Toyota Stadium","/api/v1/venues/null"]
    game = Game.new(info)
    expect(game.data[:game_id]).to eq(2012030221)
    expect(game.data[:type]).to eq("Postseason")
    expect(game.data[:date_time]).to eq("5/16/13")
    expect(game.data[:venue_link]).to eq("/api/v1/venues/null")
  end
end
