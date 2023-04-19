require "spec_helper"
require "./lib/test"

RSpec.describe Test do
  before :each do
    @test = Test.new
  end
  it 'exists' do
    expect(@test).to be_a(Test)
    expect(@test.test).to eq("test")
  end
end