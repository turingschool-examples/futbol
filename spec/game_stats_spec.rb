require 'pry'
require './lib/game_stats'

describe GameStats do
  desctibe '#initiallize' do
    it 'is created as an instance of the GameStats class' do
      expect(GameStats.new).to be GameStats
    end
  end
end