require_relative 'spec_helper'

RSpec.describe Season do
  before(:each) do
    @season_details = {
      season: '20122013',
      type: 'Postseason'
    }
    @season1 = Season.new(@season_details)
  end

  describe '#initialize' do
    it 'exists and has attributes' do
      expect(@season1).to be_a Season
      expect(@season1.years).to eq('20122013')
      expect(@season1.type).to eq('Postseason')
      expect(@season1.games).to eq([])
    end
  end
end
