require 'spec_helper'

describe StatTracker do
  it "exists" do
stat_tracker = StatTracker.new(data)

  expect(stat_tracker).to be_a StatTracker

  end
end