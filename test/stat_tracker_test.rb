require "test_helper.rb"
require_relative "../lib/stat_tracker.rb"


describe StatTracker do
  let(:stat) {StatTracker.new}

  it "should exist" do
    expect(stat).to be_kind_of(StatTracker)
  end
end
