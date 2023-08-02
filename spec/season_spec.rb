require_relative 'spec_helper'

RSpec.describe Season do
    let(:season) { Season.new("20122013", [{game_id: 123456789, away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3}]) }

  describe "#initialize" do
    it 'creates a new instance of season class' do

      expect(season).to be_a Season
    end

    it 'has readable attributes' do

      expect(season.season).to eq("20122013")
      expect(season.game_id).to eq([123456789])
      expect(season.away_team_id).to eq([3])
      expect(season.home_team_id).to eq([6])
      expect(season.away_goals).to eq([2])
      expect(season.home_goals).to eq([3])
    end
  end

  describe "#self.seasons" do
    it 'the class has an array of all the seasons made' do

      expect(Season.seasons).to all be_a Season
    end
  end
end