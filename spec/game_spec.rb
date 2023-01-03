require 'csv'
require './lib/games.rb' 

RSpec.describe Games do
  let(:game) { Game.new(info) }
  let(:info) do 
    {
    game_id: "1"
    season: "2"
    type: "sesason"
    date_time: "04/20/23"
    away_team_id: "3"
    home_team_id: "4"
    away_goals: "5"
    home_goals: "6"
    venue: "location"
    venue_link: "link name"
    } 
  end

  describe "#initialize" do
    it "exists" do
      expect(game).to be_instance_of(Game)
    end

    it "has attributes" do
      expect(game.game_id).to eq("1")
      expect(game.season).to eq("2")
      expect(game.type).to eq("sesason")
      expect(game.date_time).to eq("04/20/23")
      expect(game.away_team_id).to eq("3")
      expect(game.home_team_id).to eq("4")
      expect(game.away_goals).to eq("5")
      expect(game.home_goals).to eq("6")
      expect(game.venue).to eq("location")
      expect(game.venue_link).to eq("link name")
    end
  end 
end