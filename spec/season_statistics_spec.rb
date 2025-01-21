require './spec/spec_helper'


RSpec.describe SeasonStatistics do
  before :all do
    SeasonStatistics.set_seasoncsv('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
  end

  describe 'tackle assessment' do
    it 'can tell about tackles' do
      expect(SeasonStatistics.most_tackles("20132014")).to eq("FC Cincinnati")
      expect(SeasonStatistics.fewest_tackles("20132014")).to eq("Atlanta United")
    end
  end
  
  describe 'season coach wins' do
    it '#self.winningest_coach(season) can return the coach with the best record in a season' do
      expect(SeasonStatistics.winningest_coach("20132014")).to eq "Claude Julien"
      expect(SeasonStatistics.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    it "#self.worst_coach(season) can return the coach with the worst record in a season" do
      expect(SeasonStatistics.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(SeasonStatistics.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end
  end

  describe 'assess team shot percentage' do
    it 'most_accurate_team' do
      expect(SeasonStatistics.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(SeasonStatistics.most_accurate_team("20142015")).to eq "Toronto FC"
    end

    it 'least_accurate_team' do
      expect(SeasonStatistics.least_accurate_team("20132014")).to eq "New York City FC"
      expect(SeasonStatistics.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end
  end
end