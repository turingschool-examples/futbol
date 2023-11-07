require 'CSV'
require './lib/game'

games = []

CSV.foreach('./data/games.csv', headers: true, header_converters: :symbol) do |row|
    game_id = row[:game_id].to_i
    season = row[:season].to_i
    type = row[:type].to_s
    date_time = row[:date_time].to_s
    away_team_id = row[:away_team_id].to_i
    home_team_id = row[:home_team_id].to_i
    away_goals = row[:away_goals].to_i
    home_goals = row[:home_goals].to_i
    venue = row[:venue].to_s
    venue_link = row[:venue_link].to_s

    new_game = Game.new(game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link)

    games.append(new_game)
end

RSpec.describe Game do
    it "can correctly create new Game class instance" do
        game2012030221 = games.find { |game| game.game_id == 2012030221}

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