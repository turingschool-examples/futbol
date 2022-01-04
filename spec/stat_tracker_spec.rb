require './lib/stat_tracker'
require 'pry'
require 'simplecov'
# SimpleCov.start

RSpec.describe  StatTracker do
  it 'exists' do
    stat_tracker = StatTracker.new
    binding.pry
    expect(stat_tracker).to be_a(StatTracker)
  end
end
