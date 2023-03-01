require 'spec_helper'

RSpec.describe GamesStats do
  
  describe '#initialize' do
    it 'exists' do
      game_stat = GamesStats.new
      expect(game_stat).to be_a(GamesStats)
    end
  end
end