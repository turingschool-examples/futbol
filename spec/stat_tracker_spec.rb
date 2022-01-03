require './lib/stat_tracker'
require 'pry'
require 'simplecov'
Simplecov.start

RSpec.describe  StatTracker do
  it 'exists' do
    stat_tracker = StatTracker.new
    expect(stat_tracker).to be_a(StatTracker)
  end
end
