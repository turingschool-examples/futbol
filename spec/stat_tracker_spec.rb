require './spec/spec_helper'

RSpec.describe StatTracker do
  it "exists" do
    stat_tracker = StatTracker.new

    expect(stat_tracker).to be_a(StatTracker)
  end
end
