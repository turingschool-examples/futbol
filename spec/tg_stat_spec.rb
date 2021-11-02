require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Team Game(TG) Stat Class Tests'
require './lib/tg_stat'

RSpec.describe TGStat do
  let(:tg_stat1) { TGStat.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(tg_stat1).to be_instance_of(TGStat)
    end
  end
end