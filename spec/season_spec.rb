require "simplecov"
SimpleCov.start

require "./lib/game"
require "./lib/team"
require "./lib/season"
require "pry"
require "csv"
require "./lib/game_teams"

RSpec.describe Season do
    before do
        game_file = "./data/games_sampl.csv"
        game_team_file = "./data/game_teams_sampl.csv"
        team_data = "./data/teams_sampl.csv"
        @season = Season.new(game_file, game_team_file, "20122013", "Postseason", team_data)
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

    it "can count each game in a season" do
        expect(@season.games_count).to eq(9)
    end

    it "has average goals per season" do
        expect(@season.average_goals_per_game).to eq(1.89)
    end

    it "can generate team stats" do
        expect(@season.game_teams).to be_an(Array)
        expect(@season.game_teams[0]).to be_a(GameTeam)
    end

    it "can keep track of all game ids" do
        expect(@season.game_ids).to be_an(Array)
        expect(@season.game_ids).to eq(["2012030221", "2012030222", "2012030223", "2012030224", "2012030225", "2012030311", "2012030312", "2012030313", "2012030314"]) 
    end

    it "can generate unique team ids" do
        expect(@season.generate_team_ids).to be_an(Array)
        expect(@season.team_ids).to eq(["3", "6", "5"])
    end

    it "can generate new teams" do
        expect(@season.teams[0]).to be_a(Team)
        expect(@season.teams).to be_an(Array)
        expect(@season.teams.first.team_name).to eq("Atlanta United")
    end
    
end