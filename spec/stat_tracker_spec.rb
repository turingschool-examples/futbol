require '/spec_helper.rb'
require './lib/stat_tracker.rb'

RSpec.describe StatTracker do

  let(:stat_tracker) {StatTracker.new}

  it 'exists' do
    expect(stat_tracker).to be_instance_of(StatTracker)
  end
end
