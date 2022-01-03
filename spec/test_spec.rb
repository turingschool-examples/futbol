require './lib/test'

RSpec.describe do 'Test for simplecov'
  it 'exists' do
    test = Test.new("Bliff")
    expect(test).to be_instance_of Test
  end

  it 'has a name' do
    test = Test.new("Bliff")
    expect(test.name).to eq "Bliff"
  end
end
