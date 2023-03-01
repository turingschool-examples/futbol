require_relative '../spec/spec_helper'  

RSpec.describe StatTracker do
 
  
  describe 'initialize' do
    before(:each) do 
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
    
  end
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of StatTracker
    end

    xit 'can parse data into a string of objects' do
      expect(@stat_tracker.data(games).to be_a(Array)
      expect(@stat_tracker[games]).to all(be_a(Game))
    end
  end
end


