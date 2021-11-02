require 'csv'
require 'simplecov'
require './lib/game_stats'

RSpec.describe Game_stats do
  it 'exists' do
    game_stats = Game_stats.new

    expect(game_stats).to be_an_instance_of(Game_stats)
  end
end
