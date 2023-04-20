require './spec/spec_helper'

RSpec.describe StatTracker do 
  before(:each) do 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end
  
  describe '#initialize' do 
    it 'exists' do 
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it 'has an array of games' do 
      expect(@stat_tracker.games).to be_a Array
      expect(@stat_tracker.games[0]).to be_a Game
    end
    
    it 'has an array of gameteams' do    
      expect(@stat_tracker.game_teams).to be_a Array
      expect(@stat_tracker.game_teams[0]).to be_a GameTeam
    end
    it 'has an array of teams' do 
      expect(@stat_tracker.teams).to be_a Array
      expect(@stat_tracker.teams[0]).to be_a Team
    end
  end
end