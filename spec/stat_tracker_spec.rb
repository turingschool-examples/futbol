require 'rspec'
require 'pry'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  it "Test 1: exists" do
    tracker = StatTracker.new

    expect(tracker).to be_a(StatTracker)
  end
end