require './lib/season'
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
      searched_season = Season.new(20122013)
      expect(searched_season.within_searched_season).not_to eq nil
      require 'pry';binding.pry
    end
  end

  # describe '#most_accurate_team' do
  #   it "can return which team was most accurate in a season" do
  #     searched_season = Season.new(20122013)
  #     searched_season.most_tackles
  #     expect(searched_season.most_accurate_team).to eq('Galaxy')
  #   end
  # end


end