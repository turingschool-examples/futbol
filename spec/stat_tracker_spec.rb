require './lib/stat_tracker.rb'

RSpec.describe StatTracker do
  describe "#initialize" do
    it "can initialize StatTracker" do
      stat_tracker = StatTracker.new
      expect(stat_tracker).to be_a StatTracker
    end
  end
end