require_relative '../spec/spec_helper'  

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
  
  describe 'initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of StatTracker
    end
    
    it 'processed team data, retrieves data from teams' do
      expect(@stat_tracker.processed_teams_data(@locations)).to all(be_a(Team))
    end

    it 'processed team data, retrieves data from teams' do
      expect(@stat_tracker.processed_games_data(@locations)).to all(be_a(Game))
    end


    it 'can parse data into a string of objects' do
      expect(@stat_tracker.games).to be_a(Array)
      expect(@stat_tracker.games).to all(be_a(Game))
    end
    it 'processed team data, retrieves data from teams' do
      expect(@stat_tracker.processed_game_teams_data(@locations)).to all(be_a(GameTeam))
    end
  end

  describe '#highest_total_score' do
    it 'sum of scores in highest scoring game' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end
  end

  describe '#average_goals_per_game' do
    it 'take average of goals scored in a game across all seasons, both home and away goals' do
    expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end
  end
end


