require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  describe '#initialize' do
    it 'exists' do
      stat_tracker = StatTracker.new
      expect(stat_tracker).to be_instance_of StatTracker
    end

    it '' do

    end
  end
  
  
  describe '#self.from_csv' do
    it 'makes data accessible in class' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      StatTracker.from_csv(locations)
      # expect(@game_data).to be CSV
      # expect(@team_data).to be CSV
      # expect(@game_team_data).to be CSV
      expect(@game_data).not_to eq nil
      expect(@team_data).not_to eq nil
      expect(@game_team_data).not_to eq nil
    end
  end
end