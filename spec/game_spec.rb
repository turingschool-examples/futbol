require './lib/game'
require './lib/team'

RSpec.describe Game do 
    before :each do 
        @game1 = Game.new(2012030221,20122013,"Postseason","5/16/13",3,6,2,3,"Toyota Stadium","/api/v1/venues/null")
        @game2 = Game.new(2012030222,20122013,"Postseason","5/19/13",3,6,2,3,"Toyota Stadium","/api/v1/venues/null")
        @game3 = Game.new(2012030223,20122013,"Postseason","5/21/13",6,3,2,1,"BBVA Stadium","/api/v1/venues/null")
    end

    it 'exists' do 
       expect(@game1).to be_an_instance_of(Game)
       expect(@game2).to be_an_instance_of(Game)
       expect(@game3).to be_an_instance_of(Game) 
    end

    it 'has a game id' do
        expect(@game1.game_id).to eq(2012030221)
        expect(@game2.game_id).to eq(2012030222)
        expect(@game3.game_id).to eq(2012030223)
    end

    it 'has a season' do 
        expect(@game1.season).to eq(20122013)
        expect(@game2.season).to eq(20122013)
        expect(@game3.season).to eq(20122013)
    end

    it 'has a type of season' do 
        expect(@game1.type).to eq("Postseason")
        expect(@game2.type).to eq("Postseason")
        expect(@game3.type).to eq("Postseason")
    end

    it 'has a date' do 
        expect(@game1.date_time).to eq("5/16/13")
        expect(@game2.date_time).to eq("5/19/13")
        expect(@game3.date_time).to eq("5/21/13")
    end

    it 'has an away team id' do 
        expect(@game1.away_team_id).to eq(3)
        expect(@game2.away_team_id).to eq(3)
        expect(@game3.away_team_id).to eq(6)
    end

    it 'has a home team id' do 
        expect(@game1.home_team_id).to eq(6)
        expect(@game2.home_team_id).to eq(6)
        expect(@game3.home_team_id).to eq(3)
    end
    
    it 'has away goals' do 
        expect(@game1.away_goals).to eq(2)
        expect(@game2.away_goals).to eq(2)
        expect(@game3.away_goals).to eq(2)
    end

    it 'has home goals' do 
        expect(@game1.home_goals).to eq(3)
        expect(@game2.home_goals).to eq(3)
        expect(@game3.home_goals).to eq(1)
    end

    it 'has a venue' do 
        expect(@game1.venue).to eq("Toyota Stadium")
        expect(@game2.venue).to eq("Toyota Stadium")
        expect(@game3.venue).to eq("BBVA Stadium")
    end
    
    it 'has a venue link' do 
        expect(@game1.venue_link).to eq("/api/v1/venues/null")
        expect(@game2.venue_link).to eq("/api/v1/venues/null")
        expect(@game3.venue_link).to eq("/api/v1/venues/null")
    end
end