require './lib/stat_tracker'
require './lib/game_tracker'

RSpec.describe GameTracker do

  xit 'exists' do
    game_path       = './data/games_sample.csv'
    game_tracker = GameTracker.new(game_path)
    expect(game_tracker).to be_a(GameTracker)
  end

  xit 'converts to table' do
    game_path       = './data/games_sample.csv'
    game_tracker = GameTracker.new(game_path)
    expect(game_tracker.to_array.first).to be_a(Array)
  end



end
