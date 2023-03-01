require 'rspec'
require 'spec_helper'

RSpec.describe league do
  describe '#initialize' do
    it 'initilaizes and has attributes' do
      league1 = League.new

      expect(league1).to be_a(League)
    end
  end
end
