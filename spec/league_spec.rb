require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'League Class Tests'
require './lib/league'

RSpec.describe League do
  let(:league1) { League.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(league1).to be_instance_of(League)
    end
  end
end