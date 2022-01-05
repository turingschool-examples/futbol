require './spec_helper'


RSpec.describe 'StatTracker' do
 let(:stat_tracker) {StatTracker.new}

  it 'exists' do

    expect(stat_tracker).to be_a(StatTracker)
  end

  xit 'reads csv' do
    #need to validate expectation
    expect(stat_tracker.parse('./data/games_sample.csv').row_count).to eq(45)
  end
end
