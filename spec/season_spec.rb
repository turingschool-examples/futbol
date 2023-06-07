require './lib/game'
require './lib/team'
require './lib/season'
require 'pry'
require 'csv'

RSpec.describe Season do
    before do
        game_file = "./data/games_sampl.csv"
        game_team_file = "./game_teams_sampl.csv"
        @season = Season.new(game_file, game_team_file, "20122013", "Postseason")
    end

    it "exists" do
        expect(@season).to be_a(Season)
    end

    it "can tell us the season and type of the season" do
        expect(@season.type).to eq("Postseason")
        expect(@season.season).to eq("20122013")
    end

    it "has a series of games" do
        expect(@season.games).to be_an(Array)
        expect(@season.games.length).to eq(9)
        expect(@season.games.sample).to be_a(Game)
    end

    xit "has a coach for a given team in a given season" do

    end

    it "can count each game in a season" do
        expect(@season.games_count).to eq(9)
    end

end