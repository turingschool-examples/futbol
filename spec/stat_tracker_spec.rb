require './lib/stat_tracker.rb'

RSpec.describe StatTracker do
  it 'exists' do
    stat_tracker = StatTracker.new
    expect(stat_tracker).to be_an_instance_of(StatTracker)
  end
end
