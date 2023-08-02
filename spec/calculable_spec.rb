require "spec_helper"

describe Calculable do
  describe "#percentage" do
    it "can return a percentage to the 100th place" do
      expect(percentage(1, 3)).to be 33.33
      expect(percentage(2, 3)).to be 66.67
    end
  end
end