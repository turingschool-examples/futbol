require 'spec_helper'

RSpec.describe SeasonStats do
    before(:all) do
        @locations = {games: './data/games_fixture.csv', 
                    teams: './data/teams.csv', 
                    game_teams: './data/game_teams_fixture.csv'}
        @stat_tracker = StatTracker.from_csv(@locations)
    end

    describe "#winningest_coach" do
        it "can return winningest coach" do
            expect(@stat_tracker.winningest_coach("20122013")).to eq("Claude Julien")
        end
    end

    describe "#get_all_games" do
        it "returns an empty array if season_id doesn't match any objects" do
            expect(@stat_tracker.get_all_games("20152016")).to eq([])
        end
        it "can make an array of all game_team objects" do
            expect(@stat_tracker.get_all_games("20122013").count).to eq(20)
            expect(@stat_tracker.get_all_games("20122013")).to be_all(GameTeam)
        end
    end

    describe "#load_coach_array" do
        it "can load all coach names into an array" do
            expect(@stat_tracker.load_coach_array).to eq(["John Tortorella", "Claude Julien", "Dan Bylsma", "Mike Babcock", "Joel Quenneville"])
        end
    end

    describe "#load_coach_hash" do
        it "can create a hash with coach names as keys" do
            expect(@stat_tracker.load_coach_hash.keys).to eq(["John Tortorella", "Claude Julien", "Dan Bylsma", "Mike Babcock", "Joel Quenneville"])
        end
    end

    describe "#coach_subhash" do
        it "can create a subhash with wins and total games" do
            expect(@stat_tracker.coach_subhash("Dan Bylsma")).to eq({wins: 0, total_games: 4})
        end
    end

    describe "#coach_percentage_hash" do
        it "can create a hash with coaches as keys and win percentage as values" do
            expected_hash = {"John Tortorella" => 0.0, 
                            "Claude Julien" => 1.0, 
                            "Dan Bylsma" => 0.0, 
                            "Mike Babcock" => 0.0, 
                            "Joel Quenneville" => 1.0}


            expect(@stat_tracker.coach_percentage_hash).to eq(expected_hash)
        end
    end

    describe "#worst_coach" do
        it "can return worst coach" do
            expect(@stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
        end
    end
end