require "simplecov"
SimpleCov.start

require "csv"
require "pry"
require "./lib/game"
require "./lib/team"
require "./lib/season"
require "./lib/game_teams"

RSpec.describe GameTeam do
    before do
        game_team_file = "./data/game_teams_sampl.csv"
        game_teams = []
        game_team_lines = CSV.open game_team_file, headers: true, header_converters: :symbol
        game_team_lines.each do |line|
            game_teams << GameTeam.new(line)
        end
        @game_team_1 = game_teams[0]
        @game_team_2 = game_teams[1]
        @game_team_3 = game_teams[3]

    end

    it "exists" do
        expect(@game_team_1).to be_a(GameTeam)
    end


end