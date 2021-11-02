require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Game Class Tests'
require './lib/game'

RSpec.describe Game do
  let(:game1) { Game.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(game1).to be_instance_of(Game)
    end
  end
end