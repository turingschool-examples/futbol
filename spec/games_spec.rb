require './spec/spec_helper'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Games do
  describe '#initialize' do
    it "exists with attributes" do
      game = Games.new(2012030221, 20122013, "Postseason", "5/16/13", 3, 6, 2, 3, "Toyota Stadium", "/api/v1/venues/null")

      expect(game).to be_a Games
      expect(game.game_id).to be 2012030221
      expect(game.season).to be 20122013
      expect(game.type).to eq("Postseason")
      expect(game.date_time).to eq("5/16/13")
      expect(game.away_team_id).to be 3
      expect(game.home_team_id).to be 6
      expect(game.away_goals).to be 2
      expect(game.home_goals).to be 3
      expect(game.venue).to eq("Toyota Stadium")
      expect(game.venue_link).to eq("/api/v1/venues/null")
    end

    it "pulls data from the third row of games csv file" do
      path = "./data/games.csv"
      game_objects = Games.create_games_data_objects(path)

      expect(game_objects[2]).to be_a Games
      expect(game_objects[2].game_id).to be 2012030223
      expect(game_objects[2].season).to be 20122013
      expect(game_objects[2].type).to eq("Postseason")
      expect(game_objects[2].date_time).to eq("5/21/13")
      expect(game_objects[2].away_team_id).to be 6
      expect(game_objects[2].home_team_id).to be 3
      expect(game_objects[2].away_goals).to be 2
      expect(game_objects[2].home_goals).to be 1
      expect(game_objects[2].venue).to eq("BBVA Stadium")
      expect(game_objects[2].venue_link).to eq("/api/v1/venues/null")
    end
  end
end
  
  
  
  
  
  
 


