require "spec_helper"

RSpec.describe Test do
  before(:each) do
    @test = Test.new
  end

  describe "#initialize" do
    it "can initialize with attributes" do
      expect(@test).to be_a(Test)
      expect(@test.hello).to eq("Test")
      expect(@test.test).to eq("hello")
    end
  end
end
