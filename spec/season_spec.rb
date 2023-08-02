require './lib/season'

RSpec.describe Season do
  describe '#initialize' do
    it "can initialize" do
      season = Season.new
      expect(season).to be_a Season
    end
  end
end