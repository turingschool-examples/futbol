require "./spec_helper"

RSpec.describe GameTeam do
    describe "#initialize" do
        before do
            info = {
                game_id: "2012030314",
                team_id: "5",
                hoa: "away",
                result: "LOSS",
                settled_in: "REG",
                head_coach: "Dan Bylsma",
                goals: 0,
                shots: 6,
                tackles: 33,
                pim: "8",
                powerPlayOpportunities: "3",
                powerPlayGoals: "0",
                faceOffWinPercentage: "47.5",
                giveaways: "8",
                takeaways: "1"
            }
            @game_team = GameTeam.new(info)
        end
        
        describe "#initialize" do
            it "exists" do
                expect(@game_team).to be_instance_of GameTeam
            end

            it "has attributes" do
                expect(@game_team.game_id).to eq("2012030314")
                expect(@game_team.team_id).to eq("5")
                expect(@game_team.hoa).to eq("away")
                expect(@game_team.result).to eq("LOSS")
                expect(@game_team.settled_in).to eq("REG")
                expect(@game_team.head_coach).to eq("Dan Bylsma")
                expect(@game_team.goals).to eq(0)
                expect(@game_team.shots).to eq(6)
                expect(@game_team.tackles).to eq(33)
                expect(@game_team.pim).to eq("8")
                expect(@game_team.power_play_opportunities).to eq("3")
                expect(@game_team.power_play_goals).to eq("0")
                expect(@game_team.face_off_win_percentage).to eq("47.5")
                expect(@game_team.giveaways).to eq("8")
                expect(@game_team.takeaways).to eq("1")
            end
        end
    end
end