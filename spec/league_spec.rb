require './spec_helper'

RSpec.describe League do
  before(:each) do
    games_data = CSV.read('./data_dummy/games_dummy.csv', headers: true, header_converters: :symbol)
    games_teams_data = CSV.read('./data_dummy/game_teams_dummy.csv', headers: true, header_converters: :symbol)
    teams_data = CSV.read('./data_dummy/teams_dummy.csv', headers: true, header_converters: :symbol)

    @league = League.new(games_data, games_teams_data, teams_data)
  end

  describe "initialize" do
    it "exists" do
      expect(@league).to be_a(League)
    end
  end
end