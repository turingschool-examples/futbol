require 'spec_helper'

RSpec.configure do |config| 
 config.formatter = :documentation 
end

RSpec.describe Game do
  before(:each) do
    game_path = './data/games.csv'

    # This game data is simply an example/mock? pulled from line 2 of games.csv
    @game_data = {
      :game_id => "2012030221",
      :season => "20122013",
      :type => "Postseason",
      :away_team_id => "3",
      :home_team_id => "6",
      :away_goals => 2,
      :home_goals => 3,
      :venue_link => "/api/v1/venues/null"
    }

    @game = Game.new(@game_data)
  end

    it 'exists' do
        expect(@game).to be_a Game
    end

    it 'contains game data' do
      expect(@game.game_id).to eq("2012030221")
      expect(@game.season).to eq("20122013")
      expect(@game.type).to eq("Postseason")
      expect(@game.away_team_id).to eq("3")
      expect(@game.home_team_id).to eq("6")
      expect(@game.away_goals).to eq(2)
      expect(@game.home_goals).to eq(3)
      expect(@game.venue_link).to eq("/api/v1/venues/null")
    end

    it 'coverts home goals and aways goals from strings to ints' do
      expect(@game.away_goals).to be_a Integer
      expect(@game.away_goals).to eq(2)

      expect(@game.home_goals).to be_a Integer
      expect(@game.home_goals).to eq (3) 
      # This was tested by changing the before(:each) lines 17/18 from int back to string. Then back again.  
    end
end