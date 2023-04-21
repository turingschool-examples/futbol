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
    @test_games = @stat_tracker.games[0..100]
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

  describe 'game averages' do 
    it '#average_goals_per_game' do 
      allow(@stat_tracker).to receive(:games) {@test_games}
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end

    it 'can collect the sum of highest winning scores' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    it 'can collect the sum of lowest winning scores' do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end
  end

  describe 'percentage of wins' do 
    it 'can calculate the percentage of home wins' do 
      allow(@stat_tracker).to receive(:games) {@test_games}
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end 

    it 'can calculate the percentage of visitor wins' do 
      allow(@stat_tracker).to receive(:games) {@test_games}
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end
  end   
end