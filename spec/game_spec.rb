require './lib/game'


RSpec.describe Game do

  it 'exists and can take a hash' do
    game = Game.new({
      game_id: 1,
      type: 'away'

      })

    expect(game.type).to eq('away')
    expect(game.game_id).to eq(1)
  end




end
