# lines 3-4 could be moved to a spec_helper.rb rile --- and then we add
# require 'spec/spec_helper' to avoid adding these lines to every test file
require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'

RSpec.describe StatTracker do
  it 'exists' do
    stat_tracker = StatTracker.new
    expect(stat_tracker).to be_instance_of StatTracker
  end
end
