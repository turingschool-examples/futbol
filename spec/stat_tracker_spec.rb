require 'simplecov'
SimpleCov.start

require './lib/stat_tracker'

RSpec.describe StatTracker do

  before(:all) do
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end
  end
end
