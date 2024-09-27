require_relative 'spec_helper'

RSpec.describe Game do
  let(:game) { Game.new(info) }
  let(:info) do
    { 
      game_id: "1",
      season: "1",
      type: "string for season",
      date_time: "1",
      away_team_id: "1",
      home_team_id: "1",
      away_goals: "1",
      home_goals: "1",
      venue: "venue name",
      venue_link: "link"
    }
  end
  describe "#initialize" do

    it 'exists' do
      expect(game).to be_an_instance_of(Game)
    end

    it 'has readable attributes' do
      expect(game.game_id).to eq("1")
      expect(game.season).to eq("1")
      expect(game.type).to eq("string for season")
      expect(game.date_time).to eq("1")
      expect(game.away_team_id).to eq("1")
      expect(game.home_team_id).to eq("1")
      expect(game.away_goals).to eq(1)
      expect(game.home_goals).to eq(1)
      expect(game.venue).to eq("venue name")
      expect(game.venue_link).to eq("link")
    end
  end
end
