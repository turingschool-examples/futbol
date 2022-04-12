require 'simplecov'
SimpleCov.start
require 'pry'
require './lib/stat_tracker'

describe StatTracker do
  it "tracks stats" do
    stat = StatTracker.new("bob")
    expect(stat).to be_an_instance_of(StatTracker)
  end
end
