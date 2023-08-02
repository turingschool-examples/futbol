require "spec_helper"

describe Calculable do
  let(:test_class) {Class.new{extend Calculable}}

  describe "#percentage" do
    it "can return a percentage to the 100th place" do
      expect(test_class.percentage(1, 3)).to be 33.33
      expect(test_class.percentage(2.0, 3.0)).to be 66.67
      expect(test_class.percentage(1, [])).to eq("Inputs must be integers and/or floats.")
      expect(test_class.percentage(1, "a")).to eq("Inputs must be integers and/or floats.")
      expect(test_class.percentage(1, 0)).to eq("#DIV/0!")
      expect(test_class.percentage(1, 0.0)).to eq("#DIV/0!")
    end
  end

  describe "#average" do
    it "can return an average to the 100th place" do
      expect(test_class.average([1, 2, 13])).to be 5.33
      expect(test_class.average([1.0, 2.0, 14.0])).to be 5.67
      expect(test_class.average([1, "a", 13])).to eq("Input must be an array of integers and/or floats.")
      expect(test_class.average([])).to eq("Input must be an array of integers and/or floats.")
      expect(test_class.average("not an array")).to eq("Input must be an array of integers and/or floats.")
      expect(test_class.average(12)).to eq("Input must be an array of integers and/or floats.")
    end
  end
end