require './spec_helper'

RSpec.describe Season do
  before(:each) do
    game_path = './data_dummy/games_dummy.csv'
    games_data = CSV.read(game_path, headers: true, header_converters: :symbol)
    @season = Season.new(games_data)

    game_teams_path = './data_dummy/game_teams_dummy.csv'
    games_teams_data = CSV.read(game_teams_path, headers: true, header_converters: :symbol)
    @season2 = Season.new(games_teams_data)

    teams_path = './data_dummy/teams_dummy.csv'
    teams_data = CSV.read(teams_path, headers: true, header_converters: :symbol)
    @season3 = Season.new(teams_data)
  end

  describe "initialize" do
    it "exists" do
      expect(@season).to be_a(Season)
    end
  end

  describe "team accuracy" do
    it "returns most accurate team" do
      expect(@season2.most_accurate_team).to eq("New England Revolution")
      expect(@season2.least_accurate_team).to be_a("Sporting Kansas City")
    end
  end
end