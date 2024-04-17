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

    describe "#most_accurate_team" do
        it "can return most accurate team" do
            expect(@stat_tracker.most_accurate_team("20122013")).to eq("FC Dallas")
        end
    end

    describe "#load_team_array" do
        it "can create an array with every team_id" do
            expect(@stat_tracker.load_team_array).to eq(["3", "6", "5", "17", "16"])
        end
    end

    describe "#load_team_hash" do
        it "can create a hash with team_ids as keys" do
            expect(@stat_tracker.load_team_hash.keys).to eq(["3", "6", "5", "17", "16"])
        end
    end

    describe "#team_subhash" do
        it "can create a subhash with total shots and goals" do
            expect(@stat_tracker.team_subhash("17")).to eq({goals: 1, shots: 5})
        end
    end

    describe "#accuracy_hash" do
        it "can create a hash with team_ids as keys and accuracy ratio as values" do
            expected_hash = {"16"=>0.2, 
                            "17"=>0.2, 
                            "3"=>0.21052631578947367, 
                            "5"=>0.0625, 
                            "6"=>0.3157894736842105}

            expect(@stat_tracker.accuracy_hash).to eq(expected_hash)
        end
    end

    describe "#least_accurate_team" do
        it "can return the least accurate team" do
            expect(@stat_tracker.least_accurate_team("20122013")).to eq("Sporting Kansas City")
        end
    end

    describe "#team_index" do
        it "can pass in a team_id and return the team_name" do
            expect(@stat_tracker.team_index("17")).to eq("LA Galaxy")
        end
    end

    describe "#load_tackle_hash" do
        it "can create a hash with team_ids as keys and total tackles as values" do
            expect(@stat_tracker.load_tackle_hash).to eq({"3"=>179, "6"=>271, "5"=>150, "17"=>43, "16"=>24})
        end
    end

    describe "#get_tackles" do
        it "can retrieve total number of tackles in a season" do
            expect(@stat_tracker.get_tackles("16")).to eq(24)
        end
    end

    describe "#most_tackles" do
        it "can return team with most tackles in a season" do
            expect(@stat_tracker.most_tackles("20122013")).to eq("FC Dallas")
        end
    end

    describe "#fewest_tackles" do
        it "can return team with fewest tackles" do
            expect(@stat_tracker.fewest_tackles("20122013")).to eq("New England Revolution")
        end
    end

end