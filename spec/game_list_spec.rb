require 'spec_helper'

RSpec.describe GameList do
    it "can correctly create new Game List class instance" do
        games = GameList.new

        expect(games.array.length).to eq(7441)

        game2012030221 = games.array.find { |game| game.game_id == 2012030221}

        expect(game2012030221.game_id).to eq(2012030221)
        expect(game2012030221.season).to eq(20122013)
        expect(game2012030221.type).to eq("Postseason")
        expect(game2012030221.date_time).to eq("5/16/13")
        expect(game2012030221.away_team_id).to eq(3)
        expect(game2012030221.home_team_id).to eq(6)
        expect(game2012030221.away_goals).to eq(2)
        expect(game2012030221.home_goals).to eq(3)
        expect(game2012030221.venue).to eq("Toyota Stadium")
        expect(game2012030221.venue_link).to eq("/api/v1/venues/null")
    end
end