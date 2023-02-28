require 'spec_helper'
require './lib/game_statistics'
require 'csv'

RSpec.describe do

  let (:contents) {CSV.open 'data/games.csv', headers: true, header_converters: :symbol}
  let (:stats) {GameStatistics.new}

  describe 'highest total score' do
    it 'exists' do
      
      expect(stats).to be_a(GameStatistics)
    end
    
    it 'checks highest total score' do
      
      expect(stats.highest_total_score(contents)).to eq(8)
    end
  end

end