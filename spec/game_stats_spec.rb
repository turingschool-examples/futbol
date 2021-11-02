require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Game Statistics Class Tests'
require './lib/game_stats'

RSpec.describe GameStats do
  let(:game_stats1) { GameStats.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(game_stats1).to be_instance_of(GameStats)
    end
  end
end