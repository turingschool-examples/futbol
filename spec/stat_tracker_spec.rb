require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'

RSpec.describe 'StatTracker' do
  before(:each) do
    @stat_tracker = StatTracker.new
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end
  end
end
