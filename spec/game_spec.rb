require './spec/spec_helper'

describe Game do
  before(:each) do
    @game = Game.new("2012030221", "20122013", "Postseason", "5/16/13", 3, 6, 2, 3, "Toyota Stadium" ,"/api/v1/venues/null")
  end

  describe '#initialize' do
    it 'exists' do
      expect(@game).to be_a(Game)
    end

    it 'has a game id' do
      expect(@game.game_id).to eq("2012030221")
    end

    it 'has a season id' do
      expect(@game.season).to eq("20122013")
    end

    it 'has a game type' do
      expect(@game.type).to eq("Postseason")
    end

    it 'has a date/time' do
      expect(@game.date_time).to eq("5/16/13")
    end

    it 'has an id for the away team' do
      expect(@game.away_team_id).to eq(3)
    end

    it 'has an id for the home team' do
      expect(@game.home_team_id).to eq(6)
    end
    
    it 'has a goal total for the away team' do
      expect(@game.away_goals).to eq(2)
    end

    it 'has a goal total for the home team' do
      expect(@game.home_goals).to eq(3)
    end

    it 'has a venue' do
      expect(@game.venue).to eq("Toyota Stadium")
    end

    it 'has a venue link' do
      expect(@game.venue_link).to eq("/api/v1/venues/null")
    end
  end

end