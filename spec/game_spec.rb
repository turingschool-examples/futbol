require "./spec_helper"

RSpec.describe Game do
  before(:each) do
    @game_data = CSV.open("./data/game_teams.csv", headers: true, header_converters: :symbol)
    @game = Game.new(@game_data)
  end
  describe "win percentages" do
    it "can count total games" do
      expect(@game.game_count).to eq(14882)
    end
    # it "returns win percentages" do
    #   expect(@game.percentage_home_wins).to be_a(Float)
    #   expect(@game.percentage_away_wins).to be_a(Float)
    # end
  end
end