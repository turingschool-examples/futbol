require './lib/game.rb'

RSpec.describe Game do

  it 'exists' do
    info = ["2012030221","20122013","Postseason","5/16/13","3","6","2","3","Toyota Stadium","/api/v1/venues/null"]
    game = Game.new(info)
    expect(game).to be_a(Game)
  end

  it 'game has data' do
    info = ["2012030221","20122013","Postseason","5/16/13","3","6","2","3","Toyota Stadium","/api/v1/venues/null"]
    game = Game.new(info)
    expect(game.game_id).to eq(2012030221)
    expect(game.type).to eq("Postseason")
    expect(game.date_time).to eq("5/16/13")
    expect(game.venue_link).to eq("/api/v1/venues/null")
  end
end
