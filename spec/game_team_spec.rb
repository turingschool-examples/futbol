require './lib/game_team'

RSpec.describe GameTeam do
    it "can correctly create new Team class instance" do
        gameteam = GameTeam.new({:game_id=>2012030221, :team_id=>3, :hoa=>"away", :result=>"LOSS", :settled_in=>"OT", :head_coach=>"John Tortorella", :goals=>2, :shots=>8, :tackles=>44, :pim=>8, :powerplayopportunities=>3, :powerplaygoals=>0, :faceoffwinpercentage=>44.8, :giveaways=>17, :takeaways=>7}, nil)
        
        expect(gameteam.game_id).to eq(2012030221)
        expect(gameteam.team_id).to eq(3)
        expect(gameteam.hoa).to eq("away")
        expect(gameteam.result).to eq("LOSS")
        expect(gameteam.settled_in).to eq("OT")
        expect(gameteam.head_coach).to eq("John Tortorella")
        expect(gameteam.goals).to eq(2)
        expect(gameteam.shots).to eq(8)
        expect(gameteam.tackles).to eq(44)
        expect(gameteam.pim).to eq(8)
        expect(gameteam.powerplayopportunities).to eq(3)
        expect(gameteam.powerplaygoals).to eq(0)
        expect(gameteam.faceoffwinpercentage).to eq(44.8)
        expect(gameteam.giveaways).to eq(17)
        expect(gameteam.takeaways).to eq(7)
    end
end

#expect().to eq()