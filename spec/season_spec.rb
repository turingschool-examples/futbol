require_relative 'spec_helper'

RSpec.describe Season do
  before(:each) do
    season = Season.new({season: 20122013})
  end

  describe "#initialize" do
    it 'creates a new instance of season class' do

      expect(season).to be_a Season
    end

    it 'has readable attributes' do

      expect(season.season).to eq(20122013)
      expect(season.games_played).to eq(0)
      expect(season.avg_goals).to eq(0)
      expect(season.winningest_coach).to be nil
      expect(season.worst_coach).to be nil
      expect(season.most_accurate_team).to be nil
      expect(season.least_accurate_team).to be nil
      expect(season.most_tackles).to be nil
      expect(season.least_tackles).to be nil
  end
end