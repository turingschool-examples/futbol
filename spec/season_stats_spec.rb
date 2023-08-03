require './lib/season_stats'
require './lib/game_teams_factory'
require './lib/games_factory'
require './lib/teams_factory'


RSpec.describe Season do
  describe '#initialize' do
    it "can initialize" do
      season = Season.new(20122013)
      expect(season).to be_a Season
    end
  end

  describe '#within_searched_season' do
    it "can return games within a season" do
      searched_season2 = Season.new(20122013)
      expect(searched_season2.within_searched_season).not_to eq nil
    end
  end

  describe '#most_tackles' do
    it "can return which team has the most tackles in a season" do
      searched_season = Season.new(20122013)
      expect(searched_season.most_tackles).to eq('Sporting Kansas City')
    end
  end

  describe '#least_tackles' do
    it "can return which team has the least tackles in a seasom" do
      searched_season = Season.new(20122013)
      expect(searched_season.least_tackles).to eq('Chivas')
    end
  end



end