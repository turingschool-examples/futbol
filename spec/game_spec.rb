require 'csv'
require 'spec_helper.rb'

RSpec.describe Game do
  let(:game) { Game.new(info) }
  let(:info) do { 
      "game_id" => "99009900",
      "season" => "00110011",
      "type" => "A Good Place",
      "date_time" => "04/20/23",
      "away_team_id" => "99",
      "home_team_id" => "01",
      "away_goals" => "99",
      "home_goals" => "01",
      "venue" => "The Moon",
      "venue_link" => "/api/BE/spaceship/null"
    }
  end
  
  describe "#initialize" do
    it "exists" do
      expect(game.game_id).to be_a(Integer)
    end 

    it "has attributes" do
      expect(game.game_id).to be_a(Integer)
      expect(game.game_id).to eq(99009900)

      expect(game.season).to be_a(String)
      expect(game.season).to eq("00110011")

      expect(game.type).to be_a(String)
      expect(game.type).to eq("A Good Place")

      expect(game.date_time).to be_a(String)
      expect(game.date_time).to eq("04/20/23")

      expect(game.away_team_id).to be_a(String)
      expect(game.away_team_id).to eq("99")

      expect(game.home_team_id).to be_a(String)
      expect(game.home_team_id).to eq("01")

      expect(game.away_goals).to be_a(Integer)
      expect(game.away_goals).to eq(99)

      expect(game.home_goals).to be_a(Integer)
      expect(game.home_goals).to eq(01)

      expect(game.venue).to be_a(String)
      expect(game.venue).to eq("The Moon")

      expect(game.venue_link).to be_a(String)
      expect(game.venue_link).to eq("/api/BE/spaceship/null")
    end
  end
end