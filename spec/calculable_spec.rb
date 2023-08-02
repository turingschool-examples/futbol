require "spec_helper"

describe Calculable do
  let(:test_class) {Class.new{extend Calculable}}
  describe "#percentage" do
    it "can return a percentage to the 100th place" do
      expect(test_class.percentage(1, 3)).to be 33.33
      expect(test_class.percentage(2, 3)).to be 66.67
      expect(test_class.percentage(1, [])).to eq("Inputs must be integers or floats.")
      expect(test_class.percentage(1, 0)).to eq("#DIV/0!")
      expect(test_class.percentage(1, 0.0)).to eq("#DIV/0!")
    end
  end
end