require './spec/spec_helper'

RSpec.describe StatTracker do

  describe '#initialize' do
    it 'can create stat_tracker' do
      stat_tracker = StatTracker.new
      expect(stat_tracker.class).to be StatTracker
    end
  end
end