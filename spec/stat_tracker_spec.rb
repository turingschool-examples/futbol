require 'spec_helper'

RSpec.describe StatTracker do
  it 'exists' do
    
  end
  describe '#self.from_csv' do
    it 'returns an instance of StatTracker'
    expect(StatTracker.from_csv(locations)).to be_a StatTracker

    it 'has 3 helper methods' do


    end
  end
end
