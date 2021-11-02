require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Statistics Helper Class Tests'
require './lib/stat_helper'

RSpec.describe StatHelper do
  let(:stat_helper1) { StatHelper.new }
  
  describe '#initialize' do
    it 'exists' do
      expect(stat_helper1).to be_instance_of(StatHelper)
    end
  end
end