require './spec_helper'

RSpec.describe Season do
  before(:each) do
    games_path = './data_dummy/games_dummy.csv'
    games_data = CSV.read(game_path, headers: true, header_converters: :symbol)
    @season = League.new(games_data)

    game_teams_path = './data_dummy/game_teams_dummy.csv'
    games_teams_data = CSV.read(game_teams_path, headers: true, header_converters: :symbol)
    @season2 = League.new(games_teams_data)

    teams_path = './data_dummy/teams_dummy.csv'
    teams_data = CSV.read(teams_path, headers: true, header_converters: :symbol)
    @season3 = League.new(teams_data)
  end

  describe "initialize" do
    it "exists" do
      expect(@season).to be_a(Season)
    end
  end
end