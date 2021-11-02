require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Season Class Tests'
require './lib/season'

RSpec.describe Season do
  let(:season1) { Season.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(season1).to be_instance_of(Season)
    end
  end
end