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

end