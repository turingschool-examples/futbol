require './lib/test'
require './spec/spec_helper.rb'

RSpec.describe Test do
  subject {Test.new}
  it "tests" do
    expect(subject).to be_a(Test)
  end
end
