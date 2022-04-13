require './lib/game'
require './lib/team'
require './lib/game_teams'

RSpec.describe GameTeams do
    before :each do
        @gameteams1 = GameTeams.new(2012030221,3,"away","LOSS","OT","John Tortorella",2,8,44,8,3,0,44.8,17,7)
        @gameteams2 = GameTeams.new(2012030221,6,"home","WIN","OT","Claude Julien",3,12,51,6,4,1,55.2,4,5)
        @gameteams3 = GameTeams.new(2012030222,3,"away","LOSS","REG","John Tortorella",2,9,33,11,5,0,51.7,1,4)
    end

    it 'exists' do
       expect(@gameteams1).to be_an_instance_of(GameTeams)
       expect(@gameteams2).to be_an_instance_of(GameTeams)
       expect(@gameteams3).to be_an_instance_of(GameTeams)
    end

    it 'has a game id' do
        expect(@gameteams1.game_id).to eq(2012030221)
        expect(@gameteams2.game_id).to eq(2012030221)
        expect(@gameteams3.game_id).to eq(2012030222)
    end

    it 'has a team id' do
        expect(@gameteams1.team_id).to eq(3)
        expect(@gameteams2.team_id).to eq(6)
        expect(@gameteams3.team_id).to eq(3)
    end

    it 'is home or away' do
        expect(@gameteams1.hoa).to eq("away")
        expect(@gameteams2.hoa).to eq("home")
        expect(@gameteams3.hoa).to eq("away")
    end

    it 'is a win or loss' do
        expect(@gameteams1.result).to eq("LOSS")
        expect(@gameteams2.result).to eq("WIN")
        expect(@gameteams3.result).to eq("LOSS")
    end

    it 'settled in overtime or regular play' do
        expect(@gameteams1.settled_in).to eq("OT")
        expect(@gameteams2.settled_in).to eq("OT")
        expect(@gameteams3.settled_in).to eq("REG")
    end

    it 'has a head coach' do
        expect(@gameteams1.head_coach).to eq("John Tortorella")
        expect(@gameteams2.head_coach).to eq("Claude Julien")
        expect(@gameteams3.head_coach).to eq("John Tortorella")
    end

    it 'has goals' do
        expect(@gameteams1.goals).to eq(2)
        expect(@gameteams2.goals).to eq(3)
        expect(@gameteams3.goals).to eq(2)
    end

    it 'has shots' do
        expect(@gameteams1.shots).to eq(8)
        expect(@gameteams2.shots).to eq(12)
        expect(@gameteams3.shots).to eq(9)
    end

    it 'has tackles' do
        expect(@gameteams1.tackles).to eq(44)
        expect(@gameteams2.tackles).to eq(51)
        expect(@gameteams3.tackles).to eq(33)
    end

    it 'has a venue link' do
        expect(@gameteams1.pim).to eq(8)
        expect(@gameteams2.pim).to eq(6)
        expect(@gameteams3.pim).to eq(11)
    end

    it 'has power play opportunities' do
        expect(@gameteams1.power_play_opportunities).to eq(3)
        expect(@gameteams2.power_play_opportunities).to eq(4)
        expect(@gameteams3.power_play_opportunities).to eq(5)
    end

    it 'has power play goals' do
        expect(@gameteams1.power_play_goals).to eq(0)
        expect(@gameteams2.power_play_goals).to eq(1)
        expect(@gameteams3.power_play_goals).to eq(0)
    end

    it 'has face off win percentage' do
        expect(@gameteams1.face_off_win_percentage).to eq(44.8)
        expect(@gameteams2.face_off_win_percentage).to eq(55.2)
        expect(@gameteams3.face_off_win_percentage).to eq(51.7)
    end

    it 'has giveaways' do
        expect(@gameteams1.giveaways).to eq(17)
        expect(@gameteams2.giveaways).to eq(4)
        expect(@gameteams3.giveaways).to eq(1)
    end

    it 'has takeaways' do
        expect(@gameteams1.takeaways).to eq(7)
        expect(@gameteams2.takeaways).to eq(5)
        expect(@gameteams3.takeaways).to eq(4)
    end
end
