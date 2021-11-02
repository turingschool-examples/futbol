require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Season Statistics Class Tests'
require './lib/season_stats'

RSpec.describe SeasonStats do
  let(:season_stats1) { SeasonStats.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(season_stats1).to be_instance_of(SeasonStats)
    end
  end
end