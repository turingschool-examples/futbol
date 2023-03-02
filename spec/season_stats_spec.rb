require 'spec_helper'

RSpec.describe SeasonStats do
  before(:each) do 
    @season_stat = SeasonStats.new
  end
  describe '#initialize' do
    it 'exists' do
      expect(@season_stat).to be_a SeasonStats
    end
  end
end