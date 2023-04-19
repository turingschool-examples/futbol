require "spec_helper"

RSpec.describe StatTracker do
  before(:each) do
    @stat_tracker = StatTracker.new
  end

  describe "#initialize" do
    it "can initialize with attributes" do
      expect(@stat_tracker).to be_a(StatTracker)
    end
  end
end
