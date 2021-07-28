
require './spec/spec_helper'
require './lib/test'

RSpec.describe Test do
  it "hello" do
    test = Test.new
  expect(test.hello).to eq("Hello")
  end
end
