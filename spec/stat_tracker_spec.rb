require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'

RSpec.describe StatTracker do
  it 'exists' do
    stat_tracker = StatTracker.new
    expect(stat_tracker).to be_instance_of StatTracker
  end
end
