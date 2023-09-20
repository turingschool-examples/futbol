require './spec/spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    ## LOCATING CSV FILES
    game_team_path = './data/game_team_fixture.csv'
    games_path = './data/games_fixture.csv'
    teams_path = './data/teams.csv'
    @locations = {  game_teams: game_team_path, 
                    games: games_path, 
                    teams: teams_path,
                  }

    @stats = StatTracker.from_csv(@locations)
    @stats.create_games
    @stats.create_game_teams
    @stats.create_teams
    @stats.game_ids
    # require 'pry'; binding.pry
  end
  
  describe '#initialize' do
    it 'exists' do
      expect(@stats).to be_instance_of(StatTracker)
    end
    
    it 'has attributes' do
      expect(@stats.all_data.values.all? { |file| File.exist?(file) } ).to be true
    end
  end
  
  describe '::from_csv' do
    it 'Gets data and makes instance' do
      expect(StatTracker.from_csv(@locations)).to be_instance_of(StatTracker)
    end
  end
  
  describe '#GameStatistics' do
    it 'gets highest total score' do
      @stats.highest_total_score
      expect(@stats.highest_total_score).to eq(7)
    end

    it 'gets the lowest total score' do
      expect(@stats.lowest_total_score).to eq(1)
    end
  end

  describe 'game percentages' do
    it 'returns percentage of games home team won' do
      expect(@stats.percentage_home_wins).to be_a Float      
    end
     
    it 'returns percentage of games visitor team won' do
      expect(@stats.percentage_visitor_wins).to be_a Float
    end
    
    it 'returns percentage of games resulting in a tie' do
      expect(@stats.percentage_ties).to be_a Float
    end

    it 'rounds to 100 percent' do
      expect((@stats.percentage_ties + @stats.percentage_home_wins + @stats.percentage_visitor_wins).round).to eq(100.00)
      # require 'pry'; binding.pry
    end
  end

  describe 'league scoring' do
    it 'returns name of team with highest average when away' do
      expect(@stats.highest_scoring_visitor.class).to be String
      expect(@stats.highest_scoring_visitor).to eq('New York Red Bulls')
    end
    
    it 'returns name of team with highest average when home' do
      expect(@stats.highest_scoring_home_team.class).to be String
      expect(@stats.highest_scoring_home_team).to eq('Los Angeles FC')
    end

    it 'returns name of team with lowest average when away' do
      expect(@stats.lowest_scoring_visitor.class).to be String
      expect(@stats.lowest_scoring_visitor).to eq('Sporting Kansas City')
    end

    it 'returns name of team with lowest average when home' do
      expect(@stats.lowest_scoring_home_team.class).to be String
      expect(@stats.lowest_scoring_home_team).to eq('Sporting Kansas City')
    end
  end
end