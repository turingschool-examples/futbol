require './spec_helper'

RSpec.describe 'StatTracker' do
 let(:stat_tracker) {StatTracker.new}

  it 'exists' do

      expect(stat_tracker).to be_a(StatTracker)
  end
end
